extends Node2D

@onready var anim: AnimatedSprite2D = $Sprite
@onready var health_bar = $HealthBar
var max_health := 3
var current_health := 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_player_data()
	anim.play("idle")
	health_bar.max_value = max_health
	health_bar.value = current_health

func apply_player_data():
	if Global.selected_player_data == null:
		push_error("dafuq where is your player data? no PlayerData selected!!!")
		return
		
	anim.sprite_frames = Global.selected_player_data.idle_frames

func play_attack():
	anim.sprite_frames = Global.selected_player_data.attack_frames
	anim.play("attack")

func take_damage():
	anim.modulate = Color(0.8, 0.3, 0.3)
	await get_tree().create_timer(0.15).timeout
	anim.modulate = Color(1, 1, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sprite_animation_finished() -> void:
	if anim.animation == "attack":
		anim.sprite_frames = Global.selected_player_data.idle_frames
		anim.play("idle")


func _on_quiz_player_damaged(amount :=) -> void:
	current_health -= amount
	current_health = max(current_health, 0)
	health_bar.value = current_health
