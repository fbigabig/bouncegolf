extends Button
var toGo = "res://scenes/worlds/world1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	Musicplayer.setVolume(Musicplayer.defVol[global.curWorld])
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Musicplayer.buttonClicked()
	get_tree().change_scene_to_file(toGo)
