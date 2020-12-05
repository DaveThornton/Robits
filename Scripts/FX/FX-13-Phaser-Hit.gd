extends Node2D

export(PackedScene) var part
onready var sprite = $AnimatedSprite
#onready var sfx = $SFX_Lib

func _ready():
	sprite.play("default")


func _on_AnimatedSprite_animation_finished():
	var x = part.instance()
	Map_Hand.add_kid_to_map(x)
	x.global_position = self.global_position
	x.emitting = true
	call_deferred("free")
