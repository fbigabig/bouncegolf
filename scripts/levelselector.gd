extends Area2D

@export var level = 1
@onready var ball = $ballspin
@onready var check = $checksprite
# Called when the node enters the scene tree for the first time.
var doRC=true
func _ready():
	$RayCast2D.level=level
func setup():
	global.worldLevels.append(level)
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
	
	#var space_state = get_world_2d().direct_space_state
	## use global coordinates, not local to node
	#var query = PhysicsRayQueryParameters2D.create(global_position+Vector2(0, 0), global_position+Vector2(0, 1000))
	#query.exclude = [self]
#
	#var result = space_state.intersect_ray(query)
	#print(result)
	#if result:
		#$Line2D.add_point(to_local(result.position-Vector2(0,7)))
		#playerExitPos=result.position-Vector2(0,7)
	#else:
		#$Line2D.add_point(to_local(global_position+Vector2(0, 1000)))
		#$Line2D.default_color=Color.REBECCA_PURPLE
		#playerExitPos=position+Vector2(0,1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func doLoad():
	#get_tree().change_scene_to_file(sceneToLoad)
	Musicplayer.stopSounds()
	Musicplayer.playLev()
	global.setLevel(level)
	get_tree().change_scene_to_file(global.levels[level])
#func _on_body_entered(body):
	#if(body.is_in_group("player")):
		#print(str(global.time).pad_decimals(2))
		#call_deferred("doLoad")
