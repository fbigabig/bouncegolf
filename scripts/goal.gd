extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func doLoad():
	#get_tree().change_scene_to_file(sceneToLoad)
	global.nextLevel()
	global.exitToWorld()
func _on_body_entered(body):
	if(body.is_in_group("player")):
		print(str(global.time).pad_decimals(2))
		call_deferred("doLoad")

