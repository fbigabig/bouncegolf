extends Node

var time = 0
var currentlevel = 0
var levels = {
	0 : "res://scenes/levels/newlevel1.tscn",
	1: "res://scenes/levels/newlevel3.tscn",
	2: "res://scenes/levels/newlevel2.tscn",
	3: "res://scenes/levels/newlevel4.tscn",
	4: "res://scenes/levels/timescreen.tscn"
}
var times = [0.0,0.0,0.0,0.0,0.0]
func nextLevel():
	times[currentlevel] = time
	currentlevel=(currentlevel+1)%levels.size()
	return levels[currentlevel]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
