extends Area2D

var clearUItemplate = preload("res://prefabs/UI/clear_ui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body.is_in_group("player")):
		get_tree().paused=true
		body.UI.queue_free() #fixes focus issue
		var clearUI = clearUItemplate.instantiate()
		get_parent().add_child(clearUI)

		#print(str(global.time).pad_decimals(2))
