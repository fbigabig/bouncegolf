extends VBoxContainer

@export var time1: RichTextLabel
@export var time2: RichTextLabel
@export var time3: RichTextLabel
@export var time4: RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	time1.text = "Level 1: "+str(global.times[0]).pad_decimals(2)
	time2.text = "Level 2: "+str(global.times[1]).pad_decimals(2)
	time3.text = "Level 3: "+str(global.times[2]).pad_decimals(2)
	time4.text = "Level 4: "+str(global.times[3]).pad_decimals(2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
