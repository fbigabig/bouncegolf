extends Area2D
var dir = Vector2(0,1)
var active=true
var playerIn = false
var doEnd=false
var inProcess=false
@onready var player = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	if(is_instance_valid(global.player)):
		global.player.landed.connect(Callable(self, "_on_player_landed"))
	var rot = snapped(rotation_degrees,1)
	if(rot==0):
		dir = Vector2(0,-1)
	elif(rot==90||rot==-270):
		dir = Vector2(1,0)


	elif(rot==-90||rot==270):
		dir = Vector2(-1,0)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):

	if(body.is_in_group("player")):
		playerIn=true
		if(active):
			#print(dir)
			#print(position)
			#print("firing")
			active=false
			body.momentumCannonEntered(dir,position,self)


			

func end():
	inProcess=false
	modulate.a8=255
	active=true


func doneShooting():
	inProcess=true
	modulate.a8=50
	player.play()








func _on_player_landed():
	if(!playerIn):
		end()
	else:
		doEnd=true


func _on_body_exited(body):
	#print("doEnd")
	#print(doEnd)
	#print(playerIn)
	if(body.is_in_group("player")):
		playerIn=false
		if doEnd:
			doEnd=false
			end()
