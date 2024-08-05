extends Area2D
var dir = Vector2(0,1)
var active=true
@onready var timer = $Timer
var inProcess=false
# Called when the node enters the scene tree for the first time.
func _ready():
	var rot = snapped(rotation_degrees,1)
	print(rot)
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
	if(active):
		if(body.is_in_group("player")):
			#print(dir)
			#print(position)
			#print("firing")
			active=false
			body.momentumCannonEntered(dir,position,self)
	elif(inProcess):
		timer.stop()

			

func end():
	inProcess=false
	print("timedout")
	modulate.a8=255
	active=true
func _on_timer_timeout():
	end()

func doneShooting():
	inProcess=true
	modulate.a8=50
	timer.start()




func _on_body_exited(body):
	if(timer.is_stopped() and !active):
		end()

