extends Button

var scene = "res://scenes/levels/TitleScreen.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Musicplayer.buttonClicked()
	get_tree().change_scene_to_file(scene)
