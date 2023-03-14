extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var sprite_gun = $POS_Gun/Gun_Sprite

var shoot_pressed = false

func _process(delta):
	if walk > 0.0 && !shoot_pressed:
		if walk > 30:
			walk -= delta * 50
		else:
			walk -= delta * 40
		if walk < 0.0:
			walk = 0.0

func _physics_process(delta):
	if shoot_pressed:
		walk += delta * 90
		walk = clamp(walk,0, 90)

func shoot_j():
	shoot_pressed = true

func shoot_r():
	shoot_pressed = false
	_fire()