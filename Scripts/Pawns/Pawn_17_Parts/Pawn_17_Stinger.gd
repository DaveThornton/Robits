extends Node2D
onready var stinger = $Pawn_17_Stinger_V2
onready var rings = $CPUParticles2D
onready var big_rings = $CPUParticles2D2
onready var shield = $Pawn_17_Stinger_Shield
onready var timer = $Timer

var default_amount = 2

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func num_rings(_num: int):
	if _num > 0:
		rings.amount = _num
	else:
		rings.amount = default_amount

func color(_pri: Color, _sec: Color):
	stinger.self_modulate = _pri
	rings.self_modulate = _sec
	big_rings.self_modulate = _sec

func big_ring_on():
	big_rings.emitting = true

func big_ring_off():
	big_rings.emitting = false

func big_ring():
	timer.start()
	big_rings.emitting = true

func _on_Timer_timeout():
	big_rings.emitting = false
