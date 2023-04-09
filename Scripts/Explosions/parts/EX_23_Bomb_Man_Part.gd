extends Node2D

onready var gfx = $AnimatedSprite
onready var main_hit_box = $Area2D/CollisionShape2D

func play():
	gfx.playing = true

func line():
	gfx.animation = "Line"

func long_end():
	gfx.animation = "Long_End"

func short_end():
	gfx.animation = "Short_End"
	main_hit_box.disabled = true

func mid():
	gfx.animation = "Mid"