extends Node2D
export var color = Color ( 255, 255, 255 )
#export var warp_spot = Vector2(0,0)
onready var sprite_warp = $"Sprite-Warp"
onready var warp_spot = $Position2D
onready var anim = $AnimationPlayer

func _ready():
	sprite_warp.modulate = color
	anim.play("Default")
#	pass # Replace with function body.

#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if warp_spot:
		body.global_position = warp_spot.global_position
	else:
		print("you didn't put Position2D on the warp point you dummy")