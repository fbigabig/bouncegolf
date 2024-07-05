extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if(!global.loaded):
		global.load_func()
		global.loaded=true
	global.save_func()
	for i in get_tree().get_nodes_in_group("selector"):
		i.setText()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
