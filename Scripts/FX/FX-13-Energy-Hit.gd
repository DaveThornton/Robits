extends Node2D

onready var sprite = $AnimatedSprite
#onready var sfx = $SFX_Lib

func _ready():
	sprite.play("default")
#	SFX.play("Gun_Click")
#func _on_Timer_timeout():
#	queue_free()


func _on_AnimatedSprite_animation_finished():
	call_deferred("free")