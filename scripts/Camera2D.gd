extends Camera2D

@onready var player = get_tree().get_nodes_in_group("player")[0]  

var speed=50
var bound=25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var newPos = Vector2.ZERO
	var playerPos=player.global_position
	var diff = global_position.x-playerPos.x
	if(abs(diff)>bound):

		newPos.x = (bound-1 if diff>0 else -bound+1) + playerPos.x
	else:
		newPos.x=move_toward(global_position.x,playerPos.x,speed*delta)

	newPos.y=playerPos.y
	set_global_position(newPos.round())
		
