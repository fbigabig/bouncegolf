extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -194 #oldest is 200, old is 190.5
const ACCEL = 10 #old:10
#const ACCELBOOST = 2
const OVERDECEL = 5 #old = 3
const AIRCONTROL= 2
const CONVEYORFORCE = {
	"black": 150,
	"white": 15
}
const CONVEYOR_WHITEINITBOOSTFACTOR=10
const CONVEYORMAXFORCE = 400 #old: 350
const CONVEYORGRAVFACT = .5
#const CONVEYORSTICKYFORCE = 20
enum BounceState {
	None,
	Bouncing,
	Landing
}
@export var linelength=20
var UItemplate = preload("res://prefabs/UI/pause_UI.tscn")
var UI
var oldOnConveyor=false
var bounce:BounceState = BounceState.None
var didBounce = false
var dashFact = 2
var bounceFact = 1.00
var oldV = Vector2.ZERO
var aim_dir
var canBounce = true
var oldFloor = true
var deathSign = preload("res://prefabs/deathSign.tscn")
var oneTickGroundDelay =false

var coyotecounter = 0
var grounded = true
var onconveyor = false
var direction=1
var velOffset
var timerStarted = false
var fieldFresh = Color8(0,0,255,85)
var fieldUsed = Color8(125,0,255,85)
var paused=false
@onready var line = $aimline
@onready var cursor = $cursor
@onready var field = $bounceField
var timer
@export var interactBox = false

var gravity = 12.5
var jumpTicks = 0
const jumpTicksNum=5
@onready var wheel = $wheel
@onready var interacter = $interacter
@export var tileMap: TileMap
var hitConveyor = {
	"white": false,
	"black": false
}
func _ready():
	global.player=self
	global.time=0
	field.hide()

	timer = get_tree().get_first_node_in_group("timer")

	UI = UItemplate.instantiate() 
	get_parent().add_child.call_deferred(UI)

func _input(event):
	if(not timerStarted):
		if(not event is InputEventMouseMotion and (event.is_action("moveLeft") or event.is_action("moveRight")  or event.is_action("jump") )):
			timerStarted=true
	# Mouse in viewport coordinates.
	if(interactBox && Input.is_action_just_pressed("confirm")):
		for i in interacter.get_overlapping_areas():
			if(i.is_in_group("selector")):
				i.doLoad()

	elif Input.is_action_just_pressed("shoot")&&canBounce&&(event is InputEventMouse||aim_dir!=Vector2.ZERO):

		if(event is InputEventMouse):
			#velocity = Vector2.ZERO
			print("Mouse Click at: ", event.position)
			
			aim_dir= (get_global_mouse_position()-global_position).normalized()


		else:
			aim_dir = Input.get_vector("aimLeft", "aimRight", "aimUp", "aimDown").normalized()
		

		startBounce()

		velocity = aim_dir*SPEED*dashFact
	elif(Input.is_action_just_pressed("jump")):
		jumpTicks=jumpTicksNum
	
func startBounce():
	onconveyor=false
	oldOnConveyor=false
	bounce=BounceState.Bouncing
	field.modulate=fieldFresh
	field.show()
	
	canBounce=false
func transgenderBounce(collision):
	field.modulate=fieldUsed
	bounce=BounceState.Landing
	velocity = velocity.bounce(collision.get_normal()) * bounceFact

func endBounce():
	bounce=BounceState.None
	field.hide()

func _process(delta):
	if(timer!=null and timerStarted):
		global.time+=delta
		timer.text="[center]"+str(global.time).pad_decimals(2)+"[/center]"
	if(direction!=0):
		wheel.play()
		
		wheel.flip_h = direction<0
	else:
		wheel.pause()
func _physics_process(delta):

	for key in hitConveyor:
		hitConveyor[key]=false

	oldFloor=grounded
	# Add the gravity.
	aim_dir = Input.get_vector("aimLeft", "aimRight", "aimUp", "aimDown").normalized()

	if(aim_dir.length()==0):
		#cursor.hide()
		line.hide()
	else:
		#cursor.show()
		line.show()
	#cursor.rotation = Transform2D.IDENTITY.looking_at(aim_dir).get_rotation()
	line.set_point_position(1,aim_dir*linelength)
	var tmp = gravity *(CONVEYORGRAVFACT if oldOnConveyor else 1)

	velocity.y += tmp
	
	# Handle jump.
	if (jumpTicks>0) and (grounded||coyotecounter>0) and bounce==BounceState.None:
		print(grounded)
		print(coyotecounter)
		jumpTicks=0
		coyotecounter=0
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("moveLeft", "moveRight")

	
	velOffset = velocity.normalized()


	match bounce:
		#if direction && (abs(velocity.x)<SPEED||velocity.x*direction<0):
			#velocity.x += direction * SPEED * delta * AIRCONTROL
		BounceState.None:
			if direction && (abs(velocity.x)<SPEED||velocity.x*direction<0):

				#var acc
				#if(velocity.x*direction<0 and abs(velocity.x)<SPEED and not onconveyor): #boost acceleration if turning and not speeding (to keep exceel speed a thing you have to balance)
					#acc=ACCEL*ACCELBOOST
				#else:
					#acc=ACCEL
				velocity.x = move_toward(velocity.x,SPEED*direction,(ACCEL if is_on_floor() else ACCEL/AIRCONTROL)+(OVERDECEL if abs(velocity.x)>SPEED and velocity.x*direction<0 else 0))

				if(velocity.x*direction>0):
					velocity.x = min(SPEED,abs(velocity.x))*(1 if velocity.x>0 else -1)

			elif(!direction and !onconveyor):

				velocity.x = move_toward(velocity.x, 0, ACCEL)#*ACCELBOOST


			elif(is_on_floor()&&abs(velocity.x)>SPEED and !onconveyor):

				velocity.x = move_toward(velocity.x, SPEED, OVERDECEL) #don't steal speed too quick

			

			move_and_slide()

			oldOnConveyor=onconveyor
			onconveyor=false
			if(get_slide_collision_count()>0):
				for i in get_slide_collision_count():
					var col = get_slide_collision(i)
					
					if(!tileMap):
						hitCheck(col.get_collider())

					else:

						
						var off = (global_position-col.get_position()).normalized()+Vector2(.001,.001 ) ##offset fixes off by one error when exactly lined up
						handleTile(col.get_position()-off,col)


		BounceState.Bouncing:

			var collision = move_and_collide(velocity * delta)
			var didThing= false
			if(collision):

				if(collision.get_collider() is Node): #enable to clip through corners of one way plats
					var cold = collision.get_collider()

					#print(cold.get_groups())
					if(cold.is_in_group("gothruplat")):
						var norm = collision.get_normal()
						print("norm")
						print(norm)
						norm = snapped(norm,Vector2(.1,.1))
						if(norm.x!=0 and norm.y!=0 and !grounded):
							print(norm)
							didThing=true
							position+= velocity*delta
						#print("a")
						#if((global_position.x+2.5<cold.global_position.x-cold.w or global_position.x-2.5>cold.global_position.x+cold.w)and not grounded):
							#print("zone")
							# 
							#position+= velocity*delta
				
				if(!didThing):
					if(!tileMap):
						hitCheck(collision.get_collider())
					else:
						var off = (global_position-collision.get_position()).normalized()
						
						handleTile(collision.get_position()-off,collision)
					transgenderBounce(collision)
		BounceState.Landing:
			move_and_slide()
			oldOnConveyor=onconveyor
			onconveyor=false
			if(get_slide_collision_count()>0):
				for i in get_slide_collision_count():
					var col = get_slide_collision(i)
					if(!tileMap):
						hitCheck(col.get_collider())
					else:
						var off = (global_position-col.get_position()).normalized()
						handleTile(col.get_position()-off,col)
				endBounce()


		#var collision = move_and_collide(velocity * delta)
		#if(collision):
			#if(bounce == 2):
				#endBounce()
				#
			#elif(bounce==1):
				#bounce+=1
				#velocity = velocity.bounce(collision.get_normal()) * bounceFact
			#hitCheck(collision.get_collider())




	
			
		
	

	if(is_on_floor()&&bounce == BounceState.None):
		if(oneTickGroundDelay):
			canBounce=true
			grounded=true
		oneTickGroundDelay=true #must be on ground two frames to get stuff back
	else:
		oneTickGroundDelay=false
		grounded=false
	if(coyotecounter>0):
		coyotecounter-=1
	if(!is_on_floor() and oldFloor):
		coyotecounter=5 #start coyote timer
		
	if(jumpTicks>0):
		jumpTicks-=1

func hitCheck(obj):
	if obj is Node:
		if obj.is_in_group("hazard"):
			die()
func die():

	var dM = deathSign.instantiate()
	dM.position=position
	get_parent().add_child(dM)
	queue_free()




func eraseAll(pos,typeGoal,usedDict):
	var dat = tileMap.get_cell_tile_data(0,pos)
	var type
	if(dat):
		var thing = (dat.get_custom_data("special"))
		if(thing != ""):
			type = thing
		else:
			return
	else:
		return
	if(type==typeGoal):
		tileMap.erase_cell(0,pos)
		for i in range(-1,2):

			for j in range(-1,2):
				var newPos = pos+Vector2i(i,j)
				if(i==0 and j==0) or usedDict.has(newPos):
					continue
				eraseAll(newPos,typeGoal,usedDict)
func handleTile(tilePos, col):
	if(tileMap):

		var type
		var pos = tileMap.to_local(tilePos)
		pos= tileMap.local_to_map(pos)
		var dat = tileMap.get_cell_tile_data(0,pos)

		if(dat):
			var thing = (dat.get_custom_data("special"))
			if(thing != ""):
				type = thing
			else: 
				return
		else:

			return

		match type:
			"crumble":
				#await get_tree().create_timer(.1).timeout
				var used={}
				eraseAll(pos,"crumble",used)
				
			"conveyor_white": #white conveyors bring you up to a speed. bouncing off them does little as a result

				if(hitConveyor["white"]): return
				hitConveyor["white"]=true
				#todo: make speedy conveyor
				var force = (CONVEYORFORCE["white"]*col.get_normal()).rotated(PI/2) * (1 if oldOnConveyor else CONVEYOR_WHITEINITBOOSTFACTOR)

				onconveyor=true
				force.x=snapped(force.x,.1)
				force.y=snapped(force.y,.1)
				var normal=col.get_normal()
				var flipped = (dat.get_custom_data("value"))
			
				if(flipped==1): force*=-1

				if(abs(force.x)>.2):
					#if(force.x>0):
						#force.y=min(CONVEYORSTICKYFORCE,(force.y if force.y>0 else CONVEYORSTICKYFORCE))
					#else:
						#force.y=max(-CONVEYORSTICKYFORCE,(force.y if force.y<0 else -CONVEYORSTICKYFORCE))

					if abs(velocity.x)<CONVEYORMAXFORCE or force.x*velocity.x<0:
						velocity.x=min(abs(velocity.x+force.x),CONVEYORMAXFORCE)*(1 if velocity.x+force.x>0 else -1)

					#else:
						#print("toofast1")
					#if(velocity.x*force.x<0):velocity.x=force.x
				else:

					

					if (abs(velocity.y)<CONVEYORMAXFORCE or force.y*velocity.y<0) and (!direction or Vector2(direction,0).angle_to(normal)!=0):
						velocity.y=min(abs(velocity.y+force.y),CONVEYORMAXFORCE)*(1 if velocity.y+force.y>0 else -1)
					#if(velocity.y*force.y<0):velocity.y=force.y
					#else:
						#print("toofast2")
			"conveyor_black": #black conveyors are like dash pads- instant speed. bouncing off them will severely affect ur trajectory.
				onconveyor=true
				if(hitConveyor["black"]): return
				hitConveyor["black"]=true
				var normal=col.get_normal()
				#todo: make speedy conveyor
				var force = (CONVEYORFORCE["black"]*normal).rotated(PI/2)
				force.x=snapped(force.x,1)
				force.y=snapped(force.y,1)
				var flipped = (dat.get_custom_data("value"))

				if(flipped==1): force*=-1
				if(force.x!=0):
					if abs(velocity.x)<CONVEYORFORCE["black"] or force.x*velocity.x<0:
						velocity.x=force.x
					#else:
						#print("toofast1")
				else:

					if (abs(velocity.y)<CONVEYORFORCE["black"] or force.y*velocity.y<0) and (!direction or Vector2(direction,0).angle_to(normal)!=0):
						velocity.y=force.y

					#else:
						#print("toofast2")
						
						
		#check that stops you from grazing hazardous tiles:
		var diff = (global_position-col.get_position())
		if((diff*velOffset).length()>0.1): #ignore jumping alongside walls	
			match type:
				"bounceonly":
					if(bounce==BounceState.Bouncing):
						return
					else:
						die()
				"hazard":
					die()
				
				
				
				
			#removed: grav flip stuff, too jank and not enough room to utilize
			#"up":
				#if(gravity == gravities[type]): return
				#gravity = gravities["up"] #totally broken, need to adjust sense of floor? and xy movement to match, ugh
				#up_direction=-gravities["up"].normalized() #this causes stutters idk why
			#"down":
				#if(gravity == gravities[type]): return
				#gravity = gravities["down"]
				#up_direction=-gravities["down"].normalized()
			#"right":
				#if(gravity == gravities[type]): return
				#gravity = gravities["right"]
				#up_direction=-gravities["right"].normalized()
			#"left":
				#if(gravity == gravities[type]): return
				#gravity = gravities["left"]
				#up_direction=-gravities["left"].normalized()
				##add 4 things for each dir of grav flip tiles




