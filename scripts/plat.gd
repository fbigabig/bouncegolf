extends StaticBody2D
@onready var col = $CollisionShape2D
var w
# Called when the node enters the scene tree for the first time.
func _ready():
	w = col.shape.extents.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
"res://scripts/plat.gd"
