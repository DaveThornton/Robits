extends Node2D

onready var anim = $AnimationPlayer
onready var leg_f = $Leg_F
onready var leg_b =$Leg_B
onready var sleg_f = $F_Shield
onready var sleg_b = $B_Shield
onready var hip = $Hip


func is_right(_is_right):
	if _is_right:
		leg_f.scale.x = 1
		leg_b.scale.x = 1
		sleg_f.scale.x = 1
		sleg_b.scale.x = 1
	else:
		leg_f.scale.x = -1
		leg_b.scale.x = -1
		sleg_f.scale.x = -1
		sleg_b.scale.x = -1

func play(_anim):
	if _anim == "Run":
		anim.play("Run")
	elif _anim == "stand":
		pass
	else:
		print_debug("error in pawn 01 legs wrong animation")
	
func color(_pri, _sec):
	leg_f.self_modulate = _pri
	leg_b.self_modulate = _pri
	sleg_f.self_modulate = _sec
	sleg_b.self_modulate = _sec
	hip.self_modulate = _sec
