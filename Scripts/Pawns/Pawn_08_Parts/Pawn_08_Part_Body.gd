extends Node2D

onready var body = $Body
onready var face = $Pawn_08_Part_Face
onready var eye = $Pawn_08_Part_Face/Pawn_08_Part_Eye
onready var shield = $Shield

onready var anim_face = $AnimationFace
onready var anim_eye = $AnimationEye

func init():
	pass

func look(_pos: int, _right: bool):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1
#	if _right:
	if _pos == 1:
		anim_face.play("Up")
		return
	elif _pos == 2:
		anim_face.play("Right_Up")
		return
	elif _pos == 3:
		anim_face.play("Right")
		return
	elif _pos == 4:
		anim_face.play("Right_Down")
		return
	elif _pos == 5:
		anim_face.play("Down")
		return
#	else:
#		if _pos == 1:
#			anim_face.play("Up")
#			return
#		elif _pos == 2:
#			anim_face.play("Left_Up")
#			return
#		elif _pos == 3:
#			anim_face.play("Left")
#			return
#		elif _pos == 4:
#			anim_face.play("Left_Down")
#			return
#		elif _pos == 5:
#			anim_face.play("Down")
#			return

func play_eye(_num):
	if _num == 0:
		pass
	elif _num == 1:
		anim_eye.play("Blink")

func shield_up():
	shield.visible = true
 
func shield_down():
	shield.visible = false

func color(_pri, _sec):
	eye.self_modulate = _sec
	body.self_modulate = _pri
	shield.modulate = _sec
