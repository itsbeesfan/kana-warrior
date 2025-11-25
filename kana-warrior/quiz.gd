extends Control

var hiragana := {
	"あ": "a",
	"い": "i",
	"う": "u",
	"え": "e",
	"お": "o"
}

var correct_answer := ""
var health := 3

func _ready():
	randomize()
	new_question()
	
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

func check_answer(choice: String):
	if choice == correct_answer:
		print("correcto!!!")
	else:
		print("incorrecto!")
		damage()
		
	new_question()

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

func _on_choice_1_pressed() -> void:
	check_answer($buttons/choice1.text)
func _on_choice_2_pressed() -> void:
	check_answer($buttons/choice2.text)

func _on_choice_3_pressed() -> void:
	check_answer($buttons/choice3.text)
