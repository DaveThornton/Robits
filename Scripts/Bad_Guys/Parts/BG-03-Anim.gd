extends Node2D

export var body_color: = Color8(255, 255, 255, 255)
export var gun_color: = Color8(255, 255, 255, 255)
export var accent_color: = Color8(255, 255, 255, 255)

onready var sprite_body: = $Sprite_Body
onready var sprite_Gun: = $Sprite_Gun
onready var sprite_accent: = $Sprite_Accent
onready var anim: = $AnimationPlayer

func _ready():
	sprite_body.self_modulate = body_color
	sprite_Gun.self_modulate = gun_color
	sprite_accent.self_modulate = accent_color

func play_anim(_anim):
	anim.play(_anim)
	
#func _process(delta):
#	pass
