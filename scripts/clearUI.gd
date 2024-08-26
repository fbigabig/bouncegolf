extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():

	$levelBeat.text = "[center]Level " +str(global.currentlevel)+" Cleared![/center]"
	$timeBeat.text = "[center]Time: " +str(global.time).pad_decimals(2)+"[/center]"
	global.nextLevel()
	global.save_func()
	$Button.grab_focus() 
	print("AAAA")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func doLoad():
	Musicplayer.stopSounds()
	#get_tree().change_scene_to_file(sceneToLoad)
	get_tree().paused=false
	global.exitToWorld()
	


func _on_button_pressed():
	Musicplayer.buttonClicked()
	call_deferred("doLoad")
