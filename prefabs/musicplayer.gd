extends Node2D

@onready var player = $AudioStreamPlayer
@onready var sfxplayer = $AudioStreamPlayer2
var songs = [preload("res://assets/audio/Bit Quest.mp3"),preload("res://assets/audio/Voxel Revolution.mp3"),preload("res://assets/audio/Bit Shift.mp3"),preload("res://assets/audio/Space Fighter Loop.mp3")]
var defVol = [-10,-20,-20,-15]
var buttonClickedSound = preload("res://assets/audio/blipSelect.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	global.defVol=player.volume_db

func buttonClicked():
	if(sfxplayer.playing):
		sfxplayer.stop()
	if(sfxplayer.stream!=buttonClickedSound):
		sfxplayer.stream=buttonClickedSound
	sfxplayer.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func update():
	player.stream=songs[global.curWorld-1]
	player.play()
func setVolume(val):
	player.volume_db=val
