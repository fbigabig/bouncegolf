extends Area2D

@export var world = 1
var images = {
	1: "res://assets/worldselects/worldpicker1.png",
	2: "res://assets/worldselects/worldpicker2.png",
	3: "res://assets/worldselects/worldpicker3.png",
	4: "res://assets/worldselects/worldpicker4.png"
}
# Called when the node enters the scene tree for the first time.


func _ready():
	$Sprite2D.texture = load(images[world])
	$RichTextLabel.text="[center]"+"world "+str(world)+"[/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func doLoad():
	global.newWorld(world)
