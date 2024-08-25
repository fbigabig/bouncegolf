extends Area2D

@export var world = 1
var enabled=false
var images = {
	1: "res://assets/worldselects/worldpicker1.png",
	2: "res://assets/worldselects/worldpicker2.png",
	3: "res://assets/worldselects/worldpicker3.png",
	4: "res://assets/worldselects/worldpicker4.png"
}
# Called when the node enters the scene tree for the first time.


func setup():
	var yes= true
	#print(global.worldLevels)
	if(world>global.curWorld):
		for level in global.worldLevels:
			if(level>99): continue
			if not (global.times[level]!=0.0):
				yes = false
			#else:
				#print("failed: ")
				#print(level)
	if global.worldsUnlocked[world-1]:
		enabled=true
		$Sprite2D.texture = load(images[world])
	$RichTextLabel.text="[center]"+"world "+str(world)+"[/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func doLoad():
	if(enabled):
		global.newWorld(world)
