extends Node2D

onready var head = $Head
onready var eye = $Head/Eye
onready var mouth = $Head/Mouth
onready var shield = $Head/Shield
onready var anim_head =$AnimationPlayer_Head
onready var anim_face =$AnimationPlayer_Face

func is_right(_right):
	if _right:
		anim_head.play("Right")
		anim_face.play("Idle")
#		head.position.x = 9
#		head.frame = 0
		eye.scale.x = 1
		mouth.scale.x = 1
	else:
		anim_head.play("Left")
		anim_face.play("Idle")
#		head.position.x = -9
#		head.frame = 1
		eye.scale.x = -1
		mouth.scale.x = -1

func ladder():
		anim_head.play("ladder")
		anim_face.play("Up")
#		head.position.x = 0
#		head.frame = 2
		eye.scale.x = 1
		mouth.scale.x = 1
#		eye.frame = 2
#		mouth.frame = 2

func shield_up():
	shield.visible = true
	
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	eye.self_modulate = _sec
	mouth.self_modulate = _sec
	shield.self_modulate = _sec
