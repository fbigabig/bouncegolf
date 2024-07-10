extends Area2D
@export var toAppear = preload("res://prefabs/appearedtile.tscn")
var playerIn = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body.is_in_group("player")):
		playerIn=true





func _on_exitarea_body_exited(body):
	if(body.is_in_group("player") and playerIn):
		var temp = toAppear.instantiate()
		temp.position=position
		get_parent().add_child(temp)
		queue_free()

