extends Node2D
onready var arm = $Arm
onready var shield = $Shield
onready var anim = $AnimationPlayer

func bend(_pos: int):
	if _pos == 1:
		anim.play("90")
	elif _pos == 2:
		anim.play("135")
	elif _pos == 3:
		anim.play("180")

func is_right(_right: bool):
	if _right == true:
		self.scale.x = 1
	else:
		self.scale.x = 1

func color(_pri: Color, _sec: Color):
	arm.self_modulate = _pri
	shield.self_modulate = _sec
