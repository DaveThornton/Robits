extends Node2D

onready var light = $Pawn_05_Part_Ant_Flash

func flash():
	light.visible = true

func flash_off():
	light.visible = false

func color(_pri: Color, _sec: Color):
	light.self_modulate = _sec

func _on_Timer_timeout():
	light.visible = false
