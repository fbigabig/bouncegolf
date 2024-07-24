extends StaticBody2D
@onready var col = $CollisionShape2D
var w
var rot 
# Called when the node enters the scene tree for the first time.
func _ready():
	w = col.shape.extents.x
	rot = roundi(rad_to_deg(rotation))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	if(rot==0):
		if(is_instance_valid(global.player)): #7 for player, 3 for this thing's height. would be 4 but then u fall thru when right on top so 3.
			if(global.player.global_position.y+7+3>global_position.y and not global.player.grounded and not global.player.velocity.y>0):
				col.disabled=true
			else:
				col.disabled=false
	elif(rot==90||rot==-270):
		if(is_instance_valid(global.player)): #7 for player, 3 for this thing's height. would be 4 but then u fall thru when right on top so 3.
			if(global.player.global_position.x-7-3<global_position.x):
				col.disabled=true
			else:
				col.disabled=false


	elif(rot==180||rot==-180):

		if(is_instance_valid(global.player)): #7 for player, 3 for this thing's height. would be 4 but then u fall thru when right on top so 3.
			if(global.player.global_position.y-7-3<global_position.y and not global.player.grounded and not global.player.velocity.y<0):
				col.disabled=true
			else:
				col.disabled=false
	elif(rot==-90||rot==270):

		if(is_instance_valid(global.player)): #7 for player, 3 for this thing's height. would be 4 but then u fall thru when right on top so 3.
			if(global.player.global_position.x+7+3>global_position.x):
				col.disabled=true
			else:
				col.disabled=false

