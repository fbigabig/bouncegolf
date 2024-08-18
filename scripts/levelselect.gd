extends Node2D

# Called when the node enters the scene tree for the first time.
@onready var levels = get_tree().get_nodes_in_group("levelselector")
@onready var todo = get_tree().get_nodes_in_group("worldtodo")
func _ready():
	global.worldLevels=[]
	#print(global.loaded)
	if(!global.loaded[global.curWorld]):
		global.load_func()
		global.loaded[global.curWorld]=true
		for i in levels:
			global.levelEntryPos[i.level]=i.position

	global.save_func()
	for i in levels:
		i.setup() #use signal later maybe?
	#(global.worldLevels)
	var player = get_tree().get_nodes_in_group("player")[0]
	#print(global.levelEntryPos)
	#print(str(global.currentlevel)+" curlevel")
	#print("levelentrypos: "+ str(global.levelEntryPos))
	if(global.currentlevel==-1 and global.curWorld==4):
		player.position = Vector2(0,128)
	else:
		player.position = global.levelEntryPos[global.currentlevel]
	for i in todo:
		i.setup()
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
