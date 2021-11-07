extends Node2D

onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("default")

func _on_AnimatedSprite_animation_finished():
	queue_free()
