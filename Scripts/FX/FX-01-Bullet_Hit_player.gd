extends Node2D

onready var sprite = $AnimatedSprite
#onready var timer = $Timer

func _ready():
	sprite.play("default")

#func _on_Timer_timeout():
#	queue_free()


func _on_AnimatedSprite_animation_finished():
	queue_free()
