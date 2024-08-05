extends Node

var time = 0
var currentlevel = -1
var player
var loaded=[false,false,false,false,false]
var worldLevels = []
var levels = {
	0: "res://scenes/levels/beginnerlevel.tscn",
	1 : "res://scenes/levels/newlevel1.tscn",
	2: "res://scenes/levels/newlevel3.tscn",
	3: "res://scenes/levels/newlevel2.tscn",
	4: "res://scenes/levels/newlevel5.tscn",
	100: "res://scenes/levels/newlevel4.tscn",
	5:"res://scenes/levels/level6.tscn",
	6: "res://scenes/levels/level7.tscn",
	7: "res://scenes/levels/level_conveyor.tscn",
	8: "res://scenes/levels/level_conveyor_2.tscn",
	9: "res://scenes/levels/level_bubble_easy.tscn",
	200: "res://scenes/levels/levelbubble.tscn",
	10: "res://scenes/levels/level_ice.tscn",
	11: "res://scenes/levels/level_icesuperbounce.tscn",
	12: "res://scenes/levels/level_superbounce.tscn",
	13: "res://scenes/levels/level_cannon.tscn"
}
var worlds = {
	1: "res://scenes/worlds/world1.tscn",
	2: "res://scenes/worlds/world2.tscn",
	3: "res://scenes/worlds/world3.tscn"
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
	6: 20,
	7: 20,
	8: 20,
	200: 20,
	9: 20,
	10:20,
	11:20,
	12:20,
	13:20
}
var devTimes = {
	0: 9.11,
	1: 7.73,
	2: 10.45,
	3: 9.31,
	4: 17.76,
	100: 18.81,
	5: 8.98,
	6: 15,
	7:10,
	8: 20,
	200: 20,
	9: 20,
	10: 15,
	11:20,
	12:20,
	13:20
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


