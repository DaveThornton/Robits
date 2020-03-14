extends Node2D

#export var head_color = Color8(255, 255, 255, 255)
#export var face_color = Color8(255, 255, 255, 255)

onready var head = $Head
onready var face = $Face
onready var anim_head = $AnimationPlayer_Head
onready var anim_face = $AnimationPlayer_Face

var is_right: = false
var last_face = "Idle"
#func _ready():
#	head.modulate = head_color
#	face.modulate = face_color

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
	anim_head.play("Right")
	var _face_anim = anim_face.get_current_animation()
	if _face_anim == "Up":# || _face_anim == "":
		anim_face.play(last_face)
		
	is_right = true

func left():
	var _face_anim = anim_face.get_current_animation()
	if _face_anim == "Up":
		anim_face.play(last_face)
	anim_head.play("Left")
	is_right = false

func up():
	var _last_face = anim_face.get_current_animation()
	if _last_face == "":
		last_face = "Idle"
	elif _last_face == "Up":
		pass
	anim_head.play("Up")
	anim_face.play("Up")
	pass

func set_head_color(_head_color):
	head.modulate = _head_color

func set_face_color(_face_color):
	face.modulate = _face_color

#func _process(delta):
#	pass
