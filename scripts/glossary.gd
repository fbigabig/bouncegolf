extends Control
var mc
var grabbed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!global.player.useMouse and !grabbed):
		$Button.grab_focus()
		grabbed = true


func _on_button_pressed():
	mc.show()
	mc.get_parent().grabbed=false
	queue_free()
