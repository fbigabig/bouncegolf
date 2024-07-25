extends Area2D

@export var level = 1
@onready var ball = $ballspin
@onready var check = $checksprite
# Called when the node enters the scene tree for the first time.


func setup():
	if(!global.times.has(level)):
		global.times[level]=0.0
	$RichTextLabel.text="[center]"+"level "+str(level)+"[/center]" #add 3rd label to display best time if it exists, otherwise hide itself. goes in top middle. also get a font lazy ass.
	$timeLabel.text="[center]"+str(global.times[level]).pad_decimals(2)+"[/center]"
	if(global.times[level]<=global.flooredTimes[level] and global.times[level]!=0.0):
		ball.show()
	else:
		ball.hide()
	
	if(global.times[level]<=global.devTimes[level] and global.times[level]!=0.0):
		check.show()
	else:
		check.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func doLoad():
	#get_tree().change_scene_to_file(sceneToLoad)
	global.setLevel(level)
	get_tree().change_scene_to_file(global.levels[level])
#func _on_body_entered(body):
	#if(body.is_in_group("player")):
		#print(str(global.time).pad_decimals(2))
		#call_deferred("doLoad")

