extends Node2D

@onready var player = $AudioStreamPlayer
var songs = [preload("res://assets/audio/Bit Quest.mp3"),preload("res://assets/audio/Voxel Revolution.mp3"),preload("res://assets/audio/Bit Shift.mp3")]
var defVol = [-12,-20,-20]
# Called when the node enters the scene tree for the first time.
func _ready():
	global.defVol=player.volume_db


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func update():
	player.stream=songs[global.curWorld-1]
	player.play()
func setVolume(val):
	player.volume_db=val
	print(player.volume_db)
