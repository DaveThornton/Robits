extends Node2D
export var color = Color ( 255, 255, 255 )
#export var warp_spot = Vector2(0,0)
onready var sprite_warp = $"Sprite-Warp"
onready var warp_spot = $Position2D
onready var anim = $AnimationPlayer
onready var w1 = $"MP-12-warp-spot-01-01"
onready var w2 = $"MP-12-warp-spot-01-02"
onready var w3 = $"MP-12-warp-spot-01-03"
onready var w4 = $"MP-12-warp-spot-01-04"
onready var cpup1 = $CPUParticles2D
onready var cpup2 = $CPUParticles2D2

func _ready():
	cpup1.color = color
	cpup2.color = color
	sprite_warp.self_modulate = color
	w1.self_modulate = color
	w2.self_modulate = color
	w3.self_modulate = color
	w4.self_modulate = color
	anim.play("Current")

func _on_Area2D_body_entered(body):
	if warp_spot:
		body.global_position = warp_spot.global_position
	else:
		print_debug("you didn't put Position2D on the warp point you dummy")
