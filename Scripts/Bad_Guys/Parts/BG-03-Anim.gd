extends Node2D

export var body_color: = Color8(255, 255, 255, 255)
export var gun_color: = Color8(255, 255, 255, 255)
export var accent_color: = Color8(255, 255, 255, 255)

onready var sprite_body: = $Sprite_Body
onready var sprite_Gun: = $Sprite_Gun
onready var sprite_accent: = $Sprite_Accent
onready var anim: = $AnimationPlayer
onready var anim_shoot = $AnimationPlayer_Shoot

func _ready():
	sprite_body.self_modulate = body_color
	sprite_Gun.self_modulate = gun_color
	sprite_accent.self_modulate = accent_color

func play_anim(_anim,_num):
	if _anim == "shoot":
		shoot() 
		if _num == 3:
			anim.play("Shoot-Side")
		elif _num == 2:
			anim.play("Shoot-Up-Side")
		elif _num == 4:
			anim.play("Shoot-Down-Side")
		elif _num == 1:
			anim.play("Shoot-Up")
		elif _num == 5:
			anim.play("Shoot-Down")
		elif _num == 6:
			anim.play("Prone")
	else:
		anim.play(_anim)
	
func shoot():
	anim_shoot.play("Shoot")

func color(_pri: Color, _sec: Color):
	sprite_body.self_modulate = _pri
	sprite_Gun.self_modulate = gun_color
	sprite_accent.self_modulate = _sec
