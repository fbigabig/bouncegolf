extends Control
var parent
# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Musicplayer.buttonClicked()
	parent.visible=true
	parent.resumeButton.grab_focus()
	queue_free()
