extends VBoxContainer

@onready var resumeButton = $resume
var manual= preload("res://prefabs/UI/manual.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
	hide()
	Musicplayer.setVolume(global.defVol)
	get_tree().paused=false
	global.player.die()




func _on_level_select_pressed():
	get_tree().paused=false
	global.exitToWorld()


func _on_manual_pressed():
	var manualInst = manual.instantiate()
	manualInst.parent=self
	get_parent().add_child(manualInst)
	visible=false


func _on_quit_pressed():
	get_tree().quit()


func _on_resume_pressed():
	hide()
	Musicplayer.setVolume(global.defVol)
	get_tree().paused=false
