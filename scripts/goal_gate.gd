extends Node2D

@onready var col = $keytile/col
# Called when the node enters the scene tree for the first time.
func _ready():
	var yes = true
	for level in global.worldLevels:
		if(level>99): continue
		if not (global.times[level]<=global.flooredTimes[level] and global.times[level]!=0.0):
			yes = false
		#else:
			#print("failed: ")
			#print(level)
	if yes:
		self.modulate.a8=50
		col.disabled=true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
