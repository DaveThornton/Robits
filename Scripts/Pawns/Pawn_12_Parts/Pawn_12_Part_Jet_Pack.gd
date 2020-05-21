extends Node2D
onready var fire = $Fire
onready var pack = $Pack
onready var anim = $AnimationPlayer
onready var flame = false

func set_anim(_num: int):
	if _num == 1:
		anim.play("Fire_No")
	elif _num == 2:
		anim.play("Fire_Up")
	elif _num == 3:
		anim.play("Fire_Go")
	elif _num == 4:
		anim.play("Fire_Down")

func is_right(_right: bool):
	if _right == true:
		self.scale.x = 1
	else:
		self.scale.x = -1

func flame_up():
	if !flame:
		set_anim(2)
		flame = true

func flame_down():
	if flame:
		set_anim(4)
		flame = false
		
func color(_pri: Color, _sec: Color):
	pack.self_modulate = _pri
