extends Node2D

@onready var player = $AudioStreamPlayer
@onready var sfxplayer = $AudioStreamPlayer2
@onready var bubp = $bubblenoise
@onready var keyp = $keynoise
@onready var levp = $levelnoise
var songs = [preload("res://assets/audio/Bit Quest.mp3"),preload("res://assets/audio/Voxel Revolution.mp3"),preload("res://assets/audio/Bit Shift.mp3"),preload("res://assets/audio/Space Fighter Loop.mp3")]
var defVol = [0,-13.5,-20,-20,-15]
var buttonClickedSound = preload("res://assets/audio/blipSelect.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	global.defVol=player.volume_db
func playKey():
	keyp.play()
func playBub():
	bubp.play()
func playLev():
	levp.play()
func stopSounds():
	bubp.stop()
	levp.stop()
	keyp.stop()
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
