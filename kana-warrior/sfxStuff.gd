extends Node

var button_sfx = preload("res://resources/universfield-button-124476.mp3")
var hit_sfx = preload("res://resources/musicholder-sword-sound-260274.mp3")
var whoosh_sfx = preload("res://resources/dragon-studio-simple-whoosh-02-433006.mp3")
var countdown_sfx = preload("res://resources/tuomas_data-game-countdown-62-199828.mp3")

var sounds: Array[AudioStreamPlayer] = []

func play_sfx(sound: AudioStream, volume_db: float = 0.0):
	var player = AudioStreamPlayer.new()
	add_child(player)
	
	player.stream = sound
	player.bus = "sfx"
	player.volume_db = volume_db - 10
	player.finished.connect(func():
		player.queue_free()
	)
	sounds.append(player)
	player.play()

func play_button():
	play_sfx(button_sfx)

func play_hit():
	play_sfx(hit_sfx)
	
func play_whoosh():
	play_sfx(whoosh_sfx)

func play_countdown():
	play_sfx(countdown_sfx)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
