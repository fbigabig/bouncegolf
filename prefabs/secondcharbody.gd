extends CharacterBody2D


const SPEED = 0
const JUMP_VELOCITY = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 0


func _physics_process(delta):
	# Add the gravity.
	move_and_slide()
	print(get_slide_collision_count())
