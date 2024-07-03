extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -200.0
const ACCEL = 4
const DECEL = 15
const OVERDECEL = 4
const AIRCONTROL= 2
var bounce = 0
var didBounce = false
var dashFact = 2
var bounceFact = 1.01
var oldV = Vector2.ZERO
var aim_dir
var canBounce = true
var grounded=true
var deathSign = preload("res://prefabs/deathSign.tscn")
var oneTickGroundDelay =false
@onready var cursor = $cursor
@onready var field = $bounceField
@export var timer : RichTextLabel
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 750
func _ready():
	global.time=0
	field.hide()
func _input(event):
	# Mouse in viewport coordinates.
	
	if Input.is_action_just_pressed("shoot")&&canBounce&&(event is InputEventMouse||aim_dir!=Vector2.ZERO):

		if(event is InputEventMouse):
			#velocity = Vector2.ZERO
			print("Mouse Click at: ", event.position)
			
			aim_dir= (get_global_mouse_position()-global_position).normalized()


		else:
			aim_dir = Input.get_vector("aimLeft", "aimRight", "aimUp", "aimDown").normalized()
		

		startBounce()

		velocity= aim_dir*SPEED*dashFact

	
func startBounce():
	bounce=1
	field.show()
	canBounce=false
func endBounce():
	bounce=0
	field.hide()
	oneTickGroundDelay=true
func _process(delta):
	global.time+=delta
	timer.text=str(global.time).pad_decimals(2)
	if(velocity.x!=0):
		$wheel.play()
		$wheel.flip_h = velocity.x<0
	else:
		$wheel.pause()
func _physics_process(delta):



	# Add the gravity.
	aim_dir = Input.get_vector("aimLeft", "aimRight", "aimUp", "aimDown").normalized()

	if(aim_dir.length()==0):
		cursor.hide()
	else:
		cursor.show()
	cursor.rotation = Transform2D.IDENTITY.looking_at(aim_dir).get_rotation()
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and grounded:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("moveLeft", "moveRight")

	
	if(bounce>0):
		#if direction && (abs(velocity.x)<SPEED||velocity.x*direction<0):
			#velocity.x += direction * SPEED * delta * AIRCONTROL
		var collision = move_and_collide(velocity * delta)
		if(collision):
			if(bounce == 2):
				endBounce()
				
			elif(bounce==1):
				bounce+=1
				velocity = velocity.bounce(collision.get_normal()) * bounceFact
			hitCheck(collision.get_collider())
	else:
		if direction && (abs(velocity.x)<SPEED||velocity.x*direction<0):
			velocity.x += direction * SPEED * delta * (ACCEL if is_on_floor() else AIRCONTROL)
			if(abs(velocity.x)>SPEED):
				velocity.x=SPEED if velocity.x>0 else -SPEED

		elif(!direction):
			velocity.x = move_toward(velocity.x, 0, DECEL)
		elif(is_on_floor()&&abs(velocity.x)>SPEED):

			velocity.x = move_toward(velocity.x, SPEED, OVERDECEL)

		move_and_slide()

		for i in get_slide_collision_count():
			hitCheck(get_slide_collision(i).get_collider())
	
	
	grounded = is_on_floor()&&bounce==0&&!oneTickGroundDelay #
	if(grounded):
		canBounce=true

	if(oneTickGroundDelay): #is on floor doesn't get updated when bounce gets set to 0 because it updates with move and slide. this can lead to one frame where bounce is 0 and is on floor is true while in midair since boucing starting grounded doesn't change is_on_floor due to it using move and collide. this is why the one frame delay exists
		oneTickGroundDelay=false

	

func hitCheck(obj):
	if obj is Node:
		if obj.is_in_group("hazard"):
			var dM = deathSign.instantiate()
			dM.position=position
			get_parent().add_child(dM)
			queue_free()
