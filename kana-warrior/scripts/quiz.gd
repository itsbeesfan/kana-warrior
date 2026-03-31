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
	sensei.defeated.connect(_on_sensei_defeated)
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
	show_kana_preview(Global.new_kana)
	
	# connect the info panel thing
	player_panel.got_it_pressed.connect(_on_kana_preview_done)

func _on_sensei_defeated():
	level_complete()

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

func fade_out_level():
	black_fade.visible = true
	black_fade.modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(black_fade, "modulate:a", 1.0, 1.0)
	await tween.finished

func start_countdown():
	SfxStuff.play_countdown()
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
	
	## time to fix the shuffling
	var wrong_answers: Array = []
	for ans in hiragana.values():
		if ans != correct_answer:
			wrong_answers.append(ans)
	
	wrong_answers.shuffle()
	
	var options: Array = [correct_answer]
	options.append(wrong_answers[0])
	options.append(wrong_answers[1])
	
	options.shuffle()
	
	$buttons/choice1.text = options[0]
	$buttons/choice2.text = options[1]
	$buttons/choice3.text = options[2]

func new_round():
	current_rounds += 1
	new_question()

func level_complete():
	var next_level = Global.selected_level + 1
	
	if Global.unlocked_level < next_level:
		Global.unlocked_level = next_level
	
	print("NIVEL COMPLETADOOOOAOAOAOOAOA")
	SfxStuff.play_whoosh()
	await fade_out_level()
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
	SfxStuff.play_hit()
	await get_tree().create_timer(0.2).timeout
	sensei.take_damage()
	await get_tree().create_timer(0.2).timeout
	new_round()

func sensei_attack():
	sensei.play_attack()
	SfxStuff.play_hit()
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
	if health <= 0:
		game_over()
		
func game_over():
	print("se acabo broki")
	$buttons/choice1.disabled = true
	$buttons/choice2.disabled = true
	$buttons/choice3.disabled = true
	SfxStuff.play_whoosh()
	await fade_out_level()
	get_tree().change_scene_to_file("res://scenes/gameOver.tscn")

func _on_choice_1_pressed() -> void:
	SfxStuff.play_button()
	check_answer($buttons/choice1.text)
func _on_choice_2_pressed() -> void:
	SfxStuff.play_button()
	check_answer($buttons/choice2.text)
func _on_choice_3_pressed() -> void:
	SfxStuff.play_button()
	check_answer($buttons/choice3.text)
