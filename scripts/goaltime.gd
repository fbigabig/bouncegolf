extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text="[center][color=#33FF00]"+str(global.flooredTimes[global.currentlevel]).pad_decimals(2)+"[/color][/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
