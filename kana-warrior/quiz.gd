extends Control

@onready var player = $Player
@onready var sensei = $Sensei

var hiragana := {}

var correct_answer := ""
var health := 3

var total_rounds := 10
var current_rounds := 0

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
	new_round()
	
func new_question():
	var keys = Array(hiragana.keys())
	var random_symbol = keys[randi() % keys.size()]
	correct_answer = hiragana[random_symbol]
	
	$hiragana.text = random_symbol
	var answers = Array(hiragana.values())
	answers.shuffle()
	
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
	print("NIVEL COMPLETADOOOOAOAOAOOAOA")
	get_tree().change_scene_to_file("res://LevelComplete.tscn")

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
	get_tree().change_scene_to_file("res://gameOver.tscn")

func _on_choice_1_pressed() -> void:
	check_answer($buttons/choice1.text)
func _on_choice_2_pressed() -> void:
	check_answer($buttons/choice2.text)

func _on_choice_3_pressed() -> void:
	check_answer($buttons/choice3.text)
