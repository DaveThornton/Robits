extends Node2D

onready var sprite = $Sprite
onready var part_idle = $"Sprite/CPUParticles2D-Idle"
onready var part_go = $"Sprite/CPUParticles2D-Go"


func _ready():
	pass

func go():
	part_go.emitting = true
	part_idle.emitting = false

func idle():
	part_go.emitting = false
	part_idle.emitting = true

func stop():
	part_go.emitting = false
	part_idle.emitting = false

func is_right(_right: bool):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1

func color(_pri: Color, _sec: Color):
	part_go.self_modulate = _sec
	part_idle.self_modulate = _sec
	sprite.self_modulate = _pri
