extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 50
var grav2 = Vector2.ZERO
var bounce = false
var bouncedOnce = false
var maxVel=50

var oldV=Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _input(event):
	# Mouse in viewport coordinates.

	if event is InputEventMouseButton:
		if(event.pressed and event.button_index==1):
			#velocity = Vector2.ZERO
			print("Mouse Click at: ", event.position)
			velocity+= ((event.position-get_viewport_rect().size/2).normalized()*20)
			bounce =true
			

		elif(!event.pressed and event.button_index==1):
			pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if(abs(velocity.x)<maxVel || velocity.x * direction < 0):
			velocity.x += direction * SPEED* delta
	print(is_on_floor())
	#if(grappled):
		#var diff = hookPos-global_position
		#var angle = Vector2.UP.angle_to(to_local(hookPos)) 
		#var relVel = velocity.rotated(angle)
		#var targetVel = Vector2.ZERO
		#var accel = Vector2.ZERO
		#var tension = abs(cos(angle))*gravity
		#if(diff.y<0):
			#tension*=-1
		#var forward = abs(sin(angle))*gravity
		#if(diff.x<0):
			#forward*=-1
		#var nxtPt = hookPos+Vector2(hookLength*cos(angle),hookLength*sin(angle))
		#var vec = 
		#print(str(accel)+" "+str(relVel)+" "+str(targetVel))
		#accel=accel.rotated(-angle)
		#velocity+=accel
	var tension 
	var movedIn=false
	

		#else:
			#if(velocity.rotated(-angle).y>0):
				#
				#velocity = velocity.rotated(-angle)
				#velocity.y=0
				#velocity = velocity.rotated(angle)
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
	var vel:Vector2 = velocity
	var pos1= position

	var collision = move_and_collide(velocity * delta)


	if collision:
		if bouncedOnce:
			bounce = false
			bouncedOnce=false
		elif bounce: 
			var finalVelY = sqrt((position.y-pos1.y)*2*gravity+vel.y*vel.y)
			if(vel.y<0):
				finalVelY*=-1
			velocity.y=finalVelY
			#print(str(vel) + str(velocity)+"  12")
			velocity = velocity.bounce(collision.get_normal())
			#print(velocity)
			bouncedOnce=true
			oldV=velocity
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()
	print(bounce)
	print(bouncedOnce)
	
	#print(velocity)
	#if(grappled):
		#if(global_position.distance_to(hookPos)>hookLength):
			#var angle1 = Vector2.UP.angle_to(to_local(hookPos)) 
			#
			#var targ = hookPos+Vector2(0,hookLength).rotated(angle1)
			#global_position=(targ)
	##print(velocity)
	#print()
	if bouncedOnce:
		if(velocity.x*oldV.x<0 ||velocity.y*oldV.y<0):
			bounce = false
			bouncedOnce=false
	oldV=velocity

func _process(delta):

	pass
