extends Node

var time = 0
var currentlevel = -1

var loaded=false
var levels = {
	0: "res://scenes/levels/beginnerlevel.tscn",
	1 : "res://scenes/levels/newlevel1.tscn",
	2: "res://scenes/levels/newlevel3.tscn",
	3: "res://scenes/levels/newlevel2.tscn",
	5: "res://scenes/levels/newlevel4.tscn",
	4: "res://scenes/levels/newlevel5.tscn",
	-1: "res://scenes/levels/timescreen.tscn"
}
var levelEntryPos = {}
var times = {}
var flooredTimes = {
	0: 12,
	1: 11,
	2: 13,
	3: 13,
	4: 25,
	5: 30,
	6: 10
}
var devTimes = {
	0: 9.54,
	1: 8.23,
	2: 10.85,
	3: 9.45,
	4: 18.06,
	5: 20.7,
	6: 10
}
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
	save_game.store_line("okay")
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
	if(test!="okay"):
		return
	var num = int(save_game.get_line())

	for i in num:
		var level = int(save_game.get_line())
		times[level]=float(save_game.get_line())


