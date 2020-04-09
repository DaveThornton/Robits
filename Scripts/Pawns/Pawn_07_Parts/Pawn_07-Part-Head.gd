extends Node2D

onready var head = $Head
onready var face = $Face
onready var shield = $Shield
onready var anim_head = $AnimationPlayer_Head
onready var anim_face = $AnimationPlayer_Face

var last_face = "Idle"

func _ready():
	anim_face.play("Idle")

func play_face(_num):
	if _num == 0:
		anim_face.play("Up")
	elif _num == 1:
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
	anim_head.play("Right")
	var _face_anim = anim_face.get_current_animation()
	if _face_anim == "Up":# || _face_anim == "":
		anim_face.play(last_face)

func left():
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
	anim_head.play("Up")
	anim_face.play("Up")

func shield_up():
	shield.visible = true
 
func shield_down():
	shield.visible = false

func set_head_color(_head_color):
	head.modulate = _head_color

func set_face_color(_face_color):
	face.modulate = _face_color

func set_shield_color(_shield_color):
	shield.modulate = _shield_color
