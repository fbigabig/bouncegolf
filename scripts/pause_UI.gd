extends Node2D
var initGrab = false
@onready var UI = $buttonUI
func _input(event):
	if(event is InputEventKey or event is InputEventMouse):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif(event is InputEventJoypadButton or event is InputEventJoypadMotion):
		if(!initGrab): 
			UI.resumeButton.grab_focus()
			initGrab=true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if(Input.is_action_just_pressed("pause")):
		if(get_tree().paused):
			UI.hide()
			get_tree().paused=false
			Musicplayer.setVolume(global.defVol)
		elif(is_instance_valid(global.player)):
			#Musicplayer.buttonClicked()
			UI.show()
			initGrab = false
			get_tree().paused=true
			global.curWorld=1
			Musicplayer.update()
			Musicplayer.setVolume(global.lowVol)

# Called when the node enters the scene tree for the first time.
func _ready():
	UI.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
