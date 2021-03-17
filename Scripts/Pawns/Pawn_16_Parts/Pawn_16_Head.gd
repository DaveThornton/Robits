extends Node2D

onready var shield = $Pawn_16_Head_Shield
onready var back = $Pawn_16_Head_Back
onready var mid = $Pawn_16_Head_Mid
onready var eye = $Pawn_16_Head_Mid/Pawn_16_Head_Top
onready var anim_eye = $AnimationPlayer_Eye
onready var anim_dir = $AnimationPlayer_Dir

func _ready():
	pass # Replace with function body.

func init():
	anim_eye.play("Idle")

func look(_pos: int, _right: bool):
	if _right:
		if _pos == 1:
			anim_dir.play("Up_Right")
			return
		elif _pos == 2:
			anim_dir.play("Right_Up")
			return
		elif _pos == 3:
			anim_dir.play("Right")
			return
		elif _pos == 4:
			anim_dir.play("Right_Down")
			return
		elif _pos == 5:
			anim_dir.play("Down")
	else:
		if _pos == 1:
			anim_dir.play("Up_Left")
			return
		elif _pos == 2:
			anim_dir.play("Left_Up")
			return
		elif _pos == 3:
			anim_dir.play("Left")
			return
		elif _pos == 4:
			anim_dir.play("Left_Down")
			return
		elif _pos == 5:
			anim_dir.play("Down_Left")

func play_eye(_num:int):
	if _num == 0:
#		if anim_eye.current_animation != "Idle":
		anim_eye.play("Idle")
	elif _num == 1:
#		if anim_eye.current_animation != "Stun":
		anim_eye.play("Stun")

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func play_face(_nothing):
	pass

func color(_pri: Color, _sec: Color):
	back.self_modulate = _pri
	mid.self_modulate = _pri
	eye.self_modulate = _sec
	shield.self_modulate = _sec
