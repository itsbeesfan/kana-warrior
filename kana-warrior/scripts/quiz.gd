extends Control

@onready var player = $Player
@onready var sensei = $Sensei

@onready var player_panel = $KanaPreview
@onready var got_it_button = $KanaPreview/Button
@onready var grid = $KanaPreview/GridContainer

@onready var countdown = $Countdown

@onready var black_fade = $BlackFade

var hiragana := {}

var correct_answer := ""
var health := 3

var total_rounds := 10
var current_rounds := 0

var original_kana: Array = []
var remaining_kana: Array = []
signal player_damaged(amount)

func load_background(path):
	if path == "":
		return
	var tex: Texture2D = load(path)
	$Background.texture = tex

func _ready():
	hiragana = Global.selected_kana_set
	load_background(Global.selected_background)
	total_rounds = Global.selected_rounds
	randomize()
	#avoid massive explosion
	if hiragana.is_empty():
		push_error("kana set is empty! did you forget to select a level?")
		return
	
	#ok go
	
	original_kana = hiragana.keys().duplicate()
	remaining_kana = original_kana.duplicate()
	remaining_kana.shuffle()
	
	
	sensei.health_setup(total_rounds)
	show_kana_preview(hiragana)
	
	# connect the info panel thing
	player_panel.got_it_pressed.connect(_on_kana_preview_done)

func _on_kana_preview_done():
	player_panel.hide()
	await fade_in_level()
	start_countdown()
	
func fade_in_level():
	black_fade.visible = true
	black_fade.modulate.a = 1.0
	
	var tween = get_tree().create_tween()
	tween.tween_property(black_fade, "modulate:a", 0.0, 1.5)
	await tween.finished
	
	black_fade.visible = false
	
func start_countdown():
	countdown.show()
	countdown.text = "3"
	await get_tree().create_timer(1.0).timeout
	countdown.text = "2"
	await get_tree().create_timer(1.0).timeout
	countdown.text = "1"
	await get_tree().create_timer(1.0).timeout
	
	countdown.text = "FIGHT!"
	await get_tree().create_timer(0.75).timeout
	
	countdown.hide()
	
	new_round()

func show_kana_preview(kana_dict: Dictionary):
	player_panel.show()
	for child in grid.get_children():
		child.queue_free()
		
	for symbol in kana_dict.keys():
		var label := Label.new()
		label.text = symbol + "  -  " + kana_dict[symbol]
		grid.add_child(label)
	
func new_question():
	if remaining_kana.is_empty():
		remaining_kana = original_kana.duplicate()
		remaining_kana.shuffle()
		
	var symbol = remaining_kana.pop_back()
	correct_answer = hiragana[symbol]
	
	$hiragana.text = symbol

	var answers = hiragana.values()
	var options = [correct_answer]
	
	for ans in answers:
		if ans != correct_answer and options.size() < 3:
			options.append(ans)
	
			options.shuffle()
	
	$buttons/choice1.text = options[0]
	$buttons/choice2.text = options[1]
	$buttons/choice3.text = options[2]

func new_round():
	current_rounds += 1
	
	if current_rounds > total_rounds:
		level_complete()
		return
		
	new_question()

func level_complete():
	var next_level = Global.selected_level + 1
	
	if Global.unlocked_level < next_level:
		Global.unlocked_level = next_level
	
	print("NIVEL COMPLETADOOOOAOAOAOOAOA")
	get_tree().change_scene_to_file("res://scenes/LevelComplete.tscn")

func check_answer(choice: String):
	if choice == correct_answer:
		print("correcto!!!")
		player_attack()
	else:
		print("incorrecto!")
		sensei_attack()
		
func player_attack():
	player.play_attack()
	await get_tree().create_timer(0.2).timeout
	sensei.take_damage()
	await get_tree().create_timer(0.2).timeout
	new_round()

func sensei_attack():
	sensei.play_attack()
	await get_tree().create_timer(0.2).timeout
	player.take_damage()
	damage()
	emit_signal("player_damaged", 1)
	
	if health <= 0:
		return
	
	await get_tree().create_timer(0.2).timeout
	new_round()
	

func damage():
	health -= 1
	$health.text = "health: " + str(health)
	if health <= 0:
		game_over()
		
func game_over():
	print("se acabo broki")
	$buttons/choice1.disabled = true
	$buttons/choice2.disabled = true
	$buttons/choice3.disabled = true
	get_tree().change_scene_to_file("res://scenes/gameOver.tscn")

func _on_choice_1_pressed() -> void:
	check_answer($buttons/choice1.text)
func _on_choice_2_pressed() -> void:
	check_answer($buttons/choice2.text)

func _on_choice_3_pressed() -> void:
	check_answer($buttons/choice3.text)
