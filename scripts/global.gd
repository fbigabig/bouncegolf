extends Node

var time = 0
var currentlevel = -1
var player
var loaded=[false,false,false]
var levels = {
	0: "res://scenes/levels/beginnerlevel.tscn",
	1 : "res://scenes/levels/newlevel1.tscn",
	2: "res://scenes/levels/newlevel3.tscn",
	3: "res://scenes/levels/newlevel2.tscn",
	100: "res://scenes/levels/newlevel4.tscn",
	4: "res://scenes/levels/newlevel5.tscn",
	5:"res://scenes/levels/level6.tscn",
	6: "res://scenes/levels/level7.tscn"
}
var worlds = {
	1: "res://scenes/worlds/world1.tscn",
	2: "res://scenes/worlds/world2.tscn"
}
var curWorld = 1
var levelEntryPos = {
	-1: Vector2(-264,144) #start pos, same for every world
}
var times = {}
var flooredTimes = {
	0: 15,
	1: 15,
	2: 18,
	3: 18,
	4: 35,
	100: 40,
	5: 20,
	6: 20
}
var devTimes = {
	0: 9.11,
	1: 7.73,
	2: 10.45,
	3: 9.31,
	4: 17.76,
	100: 18.81,
	5: 8.98,
	6: 15
}
func exitToWorld():
	get_tree().change_scene_to_file(worlds[curWorld])
func newWorld(worldNum):
	curWorld=worldNum
	currentlevel=-1
	exitToWorld()
func nextLevel():
	if(time<times[currentlevel]||times[currentlevel]==0):
		times[currentlevel] = time
	
func setLevel(l):
	currentlevel=l
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func save_func():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_game.store_line("okayy")
	save_game.store_line(str(times.size()))
	for i in times:
		save_game.store_line(str(i))
		save_game.store_line(str(times[i]).pad_decimals(2))

	save_game.close()
func load_func():
	if not FileAccess.file_exists("user://savegame.save"):
		return 
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var test = save_game.get_line()
	if(test!="okayy"):
		return
	var num = int(save_game.get_line())

	for i in num:
		var level = int(save_game.get_line())
		times[level]=float(save_game.get_line())


