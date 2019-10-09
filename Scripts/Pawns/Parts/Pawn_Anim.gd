extends Node2D
export var set_face = preload("res://Sprites/Pawns/Robit_Pawn-01-00-Face.png")
export var set_body = preload("res://Sprites/Pawns/Robit_Pawn-01-00.png")
export var set_loco = preload("res://Sprites/Pawns/Robit_Pawn-01-00-Wheel.png")
export var set_shield = preload("res://Sprites/Pawns/Robit_Pawn-01-00-Shield.png")
export var set_shield_hit = preload("res://Sprites/Pawns/Robit_Pawn-01-00-Shield.png")
export var shield_color = Color8(255, 255, 255, 77)
export var shield_color_hit = Color8(255, 255, 255, 77)

onready var anim = $AnimationPlayer
onready var sprite_face = $Sprite_Face
onready var sprite_body = $Sprite_Body
onready var sprite_loco = $Sprite_Loco
onready var sprite_shield = $Sprite_Shield
onready var sprite_shield_hit = $Sprite_Shield_Hit
onready var timer = $Timer_Hit

func _ready():
	sprite_face.texture = set_face
	sprite_body.texture = set_body
	sprite_loco.texture = set_loco
	sprite_shield.texture = set_shield
	sprite_shield_hit.texture = set_shield_hit
	sprite_shield.modulate = shield_color
	sprite_shield_hit.modulate = shield_color_hit
 
func play(_animation):
	anim.play(_animation)
	pass

func shield_on():
	sprite_shield.visible = true

func shield_off():
	sprite_shield.visible = false

func hit():
	sprite_shield_hit.visible = true
	timer.start()

func _on_Timer_Hit_timeout():
	sprite_shield_hit.visible = false