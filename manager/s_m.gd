extends Node

##################################################
const BGM_STREAM: AudioStream = preload("res://sounds/time_for_adventure.mp3")

var bgm_player: AudioStreamPlayer

##################################################
func _ready() -> void:
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	bgm_player.stream = BGM_STREAM
	bgm_player.play()
