extends Node2D

onready var head = $Head
onready var face = $Face
onready var shield = $Shield
onready var anim_head = $AnimationPlayer_Head
onready var anim_face = $AnimationPlayer_Face

var last_face = "Idle"
var _is_right = true

func _ready():
	anim_face.play("Idle")

func play_face(_num):
	if _num == 0:
		anim_face.play("Up")
	if _num == 1:
		anim_face.play("Idle")
	elif _num == 2:
		anim_face.play("Off")
	elif _num == 3:
		anim_face.play("Pulse")
	elif _num == 4:
		anim_face.play("Rotate")
	elif _num == 5:
		anim_face.play("Stun")

func right():
	_is_right = true
	anim_head.play("Right")
	var _face_anim = anim_face.get_current_animation()
	if _face_anim == "Up":# || _face_anim == "":
		anim_face.play(last_face)

func left():
	_is_right = false
	var _face_anim = anim_face.get_current_animation()
	if _face_anim == "Up":
		anim_face.play(last_face)
	anim_head.play("Left")

func up():
	var _last_face = anim_face.get_current_animation()
	if _last_face == "":
		last_face = "Idle"
	elif _last_face == "Up":
		pass
	if _is_right:
		anim_head.play("Up_Right")
	else:
		anim_head.play("Up_Left")
	anim_face.play("Up")

func shield_up():
	shield.visible = true
 
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	shield.self_modulate = _sec
	face.modulate = _sec
