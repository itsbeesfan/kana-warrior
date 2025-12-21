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


func _on_first_fifteen_button_pressed() -> void:
	Global.selected_kana_set = Global.HIRAGANA_15
	Global.selected_background = "res://backgrounds/background-forest.png"
	get_tree().change_scene_to_file("res://scenes/quiz.tscn")
	Global.selected_rounds = 10
	Global.selected_player_data = preload("res://resources/player_level2.tres")
	Global.selected_level = 2


func _on_first_twenty_five_button_pressed() -> void:
	Global.selected_kana_set = Global.HIRAGANA_25
	Global.selected_background = "res://backgrounds/background-torii.png"
	get_tree().change_scene_to_file("res://scenes/quiz.tscn")
	Global.selected_rounds = 15
	Global.selected_player_data = preload("res://resources/player_level3.tres")
	Global.selected_level = 3


func _on_first_thirty_five_button_pressed() -> void:
	pass # Replace with function body.


func _on_all_hiragana_button_pressed() -> void:
	pass # Replace with function body.
