extends Node

var music_player: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	music_player.stream = preload("res://resources/How Sweet (Instrumental).mp3")
	## music by newjeans!!! TE AMO NEWJEANS PORFA VUELVAN FDHJKHDSFJJ
	music_player.bus = "music"
	music_player.autoplay = false
	music_player.volume_db = -20
	
	music_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
