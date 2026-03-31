extends Control


#copy paste for all scenes
var button_sfx = preload("res://resources/universfield-button-124476.mp3")
var hit_sfx = preload("res://resources/musicholder-sword-sound-260274.mp3")
var whoosh_sfx = preload("res://resources/dragon-studio-simple-whoosh-02-433006.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	SfxStuff.play_button()
	get_tree().change_scene_to_file("res://scenes/selectLevel.tscn")


func _on_settings_pressed() -> void:
	SfxStuff.play_button()
	get_tree().change_scene_to_file("res://scenes/OptionScreen.tscn")


func _on_exit_pressed() -> void:
	await SfxStuff.play_hit()
	get_tree().quit()
