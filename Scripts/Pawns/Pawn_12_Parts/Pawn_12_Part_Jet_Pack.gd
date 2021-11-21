extends Node2D
onready var fire = $Fire
onready var pack = $Pack
onready var anim = $AnimationPlayer
onready var flame = false
onready var shield = $Shield

func set_anim(_num: int):
	if _num == 1:
		anim.play("Fire_No")
	elif _num == 2:
		anim.play("Fire_Up")
	elif _num == 3:
		anim.play("Fire_Go")
	elif _num == 4:
		anim.play("Fire_Down")

func new_pos(_num:int):
	if _num == 1:#right
		pack.frame = 0
		pack.position.x = -12
		fire.position.x = -12
	elif _num == 2:#left
		pack.frame = 1
		pack.position.x = 12
		fire.position.x = 12
	elif _num == 3:#up ladder
		pack.frame = 2
		pack.position.x = 0
		fire.position.x = 0

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

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
	shield.self_modulate = _sec
