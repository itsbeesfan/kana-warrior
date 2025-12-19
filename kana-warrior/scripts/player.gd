extends Node2D

@onready var sprite := $Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("idle")

func play_attack():
	sprite.play("attack")

func take_damage():
	sprite.modulate = Color(0.8, 0.3, 0.3)
	await get_tree().create_timer(0.15).timeout
	sprite.modulate = Color(1, 1, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sprite_animation_finished() -> void:
	if sprite.animation == "attack":
		sprite.play("idle")
