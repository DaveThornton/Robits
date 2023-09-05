extends Node2D

onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("default")
	SFX.hit_player()

func _on_AnimatedSprite_animation_finished():
	queue_free()