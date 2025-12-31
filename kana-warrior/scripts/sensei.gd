extends Node2D

@onready var sprite := $Sprite
@onready var health_bar := $HealthBar
signal defeated

var max_health := 1
var current_health := 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("idle")

func play_attack():
	sprite.play("attack")

func take_damage(amount :=1):
	sprite.modulate = Color(0.8, 0.3, 0.3)
	await get_tree().create_timer(0.15).timeout
	sprite.modulate = Color(1, 1, 1)
	current_health -= amount
	health_bar.value = current_health
	
	if current_health <= 0:
		emit_signal("defeated") 

func health_setup(max_hp: int):
	max_health = max_hp
	current_health = max_hp
	health_bar.max_value = max_hp
	health_bar.value = max_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sprite_animation_finished() -> void:
	if sprite.animation == "attack":
		sprite.play("idle")
