extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var particles = $POS_Gun/Gun_Sprite/CPUParticles2D

var clicked = false 

func shoot():
	_fire()

func empty():
	if !clicked:
		SFX.play("Laser_Empty")
		clicked = true

func shoot_r():
	clicked = false