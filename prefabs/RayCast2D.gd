extends RayCast2D

var level
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):

	var p = get_collision_point()

	if(p!=Vector2.ZERO):
		global.levelEntryPos[level]=(p)-Vector2(0,7)
		queue_free()
