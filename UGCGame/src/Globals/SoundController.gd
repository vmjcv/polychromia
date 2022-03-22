extends Node

var bgmPlayer:AudioStreamPlayer
var sfxPlayer:AudioStreamPlayer

func _ready():
	bgmPlayer = AudioStreamPlayer.new()
	bgmPlayer.bus = "BGM"

	sfxPlayer = AudioStreamPlayer.new()
	sfxPlayer.bus = "SFX"
	
	add_child(bgmPlayer)
	add_child(sfxPlayer)

func play_sound(sfx:AudioStream):
	sfxPlayer.stream = sfx
	sfxPlayer.play()

func play_music(bgm:AudioStream):
	bgmPlayer.stream = bgm
	bgmPlayer.play()

func set_volume(player:AudioStreamPlayer, percentage:float):
	if not percentage:
		player.volume_db = - 80
		return 
	player.volume_db = 10 * log(percentage / 100) / log(10)
	

