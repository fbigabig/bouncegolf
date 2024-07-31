extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	var floorTime = global.flooredTimes[global.currentlevel]
	var bestTime = global.times[global.currentlevel]
	if(bestTime<floorTime and bestTime!=0):
		self.text="[center][color=#33FF00]"+str(bestTime).pad_decimals(2)+"[/color][/center]"
	else:
		self.text="[center][color=#FF0000]"+str(floorTime).pad_decimals(2)+"[/color][/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
