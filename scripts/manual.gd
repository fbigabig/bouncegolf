extends Control
var parent
var glossary = preload("res://prefabs/UI/glossary.tscn")
var grabbed = false
@onready var b2 = $manualcontrol/Button2
@onready var mc = $manualcontrol
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!global.player.useMouse and !grabbed):
		b2.grab_focus()
		grabbed = true


func _on_button_pressed():
	Musicplayer.buttonClicked()
	var g = glossary.instantiate()
	g.mc = mc
	add_child(g)
	mc.hide()
	


func _on_button_2_pressed():
	Musicplayer.buttonClicked()
	parent.visible=true
	parent.resumeButton.grab_focus()
	queue_free()
