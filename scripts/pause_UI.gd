extends Node2D

@onready var UI = $buttonUI
func _input(event):
	if(Input.is_action_just_pressed("pause")):
		if(get_tree().paused):
			UI.hide()
			get_tree().paused=false
		elif(is_instance_valid(global.player)):
			UI.show()
			UI.restartButton.grab_focus()
			get_tree().paused=true

# Called when the node enters the scene tree for the first time.
func _ready():
	UI.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
