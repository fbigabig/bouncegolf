extends Node2D

@export var world = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	if global.worldsUnlocked[world-1]:
		$stuff.show()
		$infotext.hide()
	else:
		$stuff.hide()
		$infotext.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
