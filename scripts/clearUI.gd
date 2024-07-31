extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.grab_focus()
	$levelBeat.text = "[center]Level " +str(global.currentlevel)+" Cleared![/center]"
	$timeBeat.text = "[center]Time: " +str(global.time).pad_decimals(2)+"[/center]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func doLoad():
	#get_tree().change_scene_to_file(sceneToLoad)
	get_tree().paused=false
	global.nextLevel()
	global.exitToWorld()
	


func _on_button_pressed():
	call_deferred("doLoad")
