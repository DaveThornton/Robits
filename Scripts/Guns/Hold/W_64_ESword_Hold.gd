extends 'res://Scripts/Guns/Hold/W_00_Gun_Melee_Hold.gd'

onready var timer = $Timer
onready var anim = $AnimationPlayer

var pawn

var swung = false
func post_set_up():
	pawn = Controllers.get_pawn(player)

func shoot_j():
	swing()
	# swinging = true
	if pawn && !swung:
		print_debug("knocking back")
		pawn.knock_back(-500, .2)
		swung = true
	timer.start()
	swung = true

func _on_Timer_timeout():
	anim.play("Flash")
	swung = false
