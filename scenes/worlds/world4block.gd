extends StaticBody2D
@onready var col = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func setup():
	var yes = true
	for level in global.levels:
		if(level>300): continue
		if not global.times.has(level):
			yes=false
			#print(level)
			break
		if not (global.times[level]<=global.flooredTimes[level] and global.times[level]!=0.0):
			yes = false
			#print(level)
			break

	if yes:
		self.modulate.a8=50
		col.disabled=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
