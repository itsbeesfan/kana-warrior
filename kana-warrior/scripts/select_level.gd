extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in get_tree().get_nodes_in_group("level_buttons"):
		if button.level_number > Global.unlocked_level:
			button.disabled = true
		else:
			button.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_first_five_button_pressed() -> void:
	Global.selected_kana_set = Global.HIRAGANA_5
	Global.selected_background = "res://backgrounds/background-dojo.png"
	get_tree().change_scene_to_file("res://scenes/quiz.tscn")
	Global.selected_rounds = 5
	Global.selected_player_data = preload("res://resources/player_level1.tres")
	Global.selected_level = 1
	Global.new_kana = Global.HIRAGANA_5


func _on_first_fifteen_button_pressed() -> void:
	Global.selected_kana_set = Global.HIRAGANA_15
	Global.selected_background = "res://backgrounds/background-forest.png"
	get_tree().change_scene_to_file("res://scenes/quiz.tscn")
	Global.selected_rounds = 10
	Global.selected_player_data = preload("res://resources/player_level2.tres")
	Global.selected_level = 2
	Global.new_kana = {"か":"ka", "き":"ki", "く":"ku", "け":"ke", "こ":"ko",
	"さ":"sa", "し":"shi", "す":"su", "せ":"se", "そ":"so"}


func _on_first_twenty_five_button_pressed() -> void:
	Global.selected_kana_set = Global.HIRAGANA_25
	Global.selected_background = "res://backgrounds/background-torii.png"
	get_tree().change_scene_to_file("res://scenes/quiz.tscn")
	Global.selected_rounds = 15
	Global.selected_player_data = preload("res://resources/player_level3.tres")
	Global.selected_level = 3
	Global.new_kana = {"た":"ta", "ち":"chi", "つ":"tsu", "て":"te", "と":"to",
	"な":"na", "に":"ni", "ぬ":"nu", "ね":"ne", "の":"no"}


func _on_first_thirty_five_button_pressed() -> void:
	Global.selected_kana_set = Global.HIRAGANA_35
	#Global.selected_background = "res://backgrounds/background-city.png"
	get_tree().change_scene_to_file("res://scenes/quiz.tscn")
	Global.selected_rounds = 20
	Global.selected_level = 4
	Global.new_kana = {"は":"ha", "ひ":"hi", "ふ":"fu", "へ":"he", "ほ":"ho",
	"ま":"ma", "み":"mi", "む":"mu", "め":"me", "も":"mo"}


func _on_all_hiragana_button_pressed() -> void:
	Global.selected_kana_set = Global.HIRAGANA_ALL
	#Global.selected_background = "res://backgrounds/background-nose.png"
	get_tree().change_scene_to_file("res://scenes/quiz.tscn")
	Global.selected_rounds = 25
	Global.selected_level = 5
	Global.new_kana = {"や":"ya", "ゆ":"yu", "よ":"yo",
	"ら":"ra", "り":"ri", "る":"ru", "れ":"re", "ろ":"ro",
	"わ":"wa", "ん":"n"}


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/startScreen.tscn")
