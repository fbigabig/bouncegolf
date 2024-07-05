extends Area2D

@export var level = 1

# Called when the node enters the scene tree for the first time.
func setText():
	$RichTextLabel.text="[center]"+"level "+str(level)+"[/center]"
	$timeLabel.text="[center]"+str(global.times[level]).pad_decimals(2)+"[/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func doLoad():
	#get_tree().change_scene_to_file(sceneToLoad)
	global.setLevel(level)
	get_tree().change_scene_to_file(global.levels[level])
#func _on_body_entered(body):
	#if(body.is_in_group("player")):
		#print(str(global.time).pad_decimals(2))
		#call_deferred("doLoad")

