extends Node

var time = 0
var currentlevel = 0
var loaded=false
var levels = {
	1 : "res://scenes/levels/newlevel1.tscn",
	2: "res://scenes/levels/newlevel3.tscn",
	3: "res://scenes/levels/newlevel2.tscn",
	4: "res://scenes/levels/newlevel4.tscn",
	-1: "res://scenes/levels/timescreen.tscn"
}
var times = [0.0,0.0,0.0,0.0,0.0,0.0]
func nextLevel():
	if(time<times[currentlevel]):
		times[currentlevel] = time
	
func setLevel(l):
	currentlevel=l
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func save_func():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_game.store_line(str(times.size()))
	for i in times:
		save_game.store_line(str(i).pad_decimals(2))
		print(i)
	save_game.close()
func load_func():
	if not FileAccess.file_exists("user://savegame.save"):
		return 
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var num = int(save_game.get_line())
	times.resize(num)
	for i in num:
		times[i]=float(save_game.get_line())
		print(times[i])

