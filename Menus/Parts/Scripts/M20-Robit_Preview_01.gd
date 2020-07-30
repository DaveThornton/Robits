extends Node2D

onready var sprite = $Sprite
onready var sprite2 = $AnimatedSprite

export var player = 1

func _ready():
	sprite2.modulate = Player_Stats.get_body_color(player)

func set_pic(_pawn):
	if _pawn < 17:
		sprite.frame = _pawn - 1
	else:
		print("error in Robit preview bad pawn number")
