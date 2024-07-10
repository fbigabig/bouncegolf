extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var levels = get_tree().get_nodes_in_group("selector")
func _ready():

	if(!global.loaded):
		global.load_func()
		global.loaded=true
		global.levelEntryPos[-1] = Vector2(-280,144)
		for i in levels:
			global.levelEntryPos[i.level]=i.position
	global.save_func()
	for i in levels:
		i.setup()
	var player = get_tree().get_nodes_in_group("player")[0]
	player.position = global.levelEntryPos[global.currentlevel]
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
