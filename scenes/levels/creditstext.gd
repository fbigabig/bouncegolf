extends RichTextLabel
@export var goal = 700
var scene = "res://scenes/levels/TitleScreen.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y-= 10*delta
	if(position.y<-goal):
		position.y=160

