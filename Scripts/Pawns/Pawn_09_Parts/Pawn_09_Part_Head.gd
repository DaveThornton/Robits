extends Node2D

onready var head = $Head
onready var hat = $Hat
onready var face = $Face
onready var shield = $Shield


func shield_up():
	pass

func shield_down():
	pass

func color(_pri, _sec):
	head.self_modulate = _pri
	face.self_modulate = _sec
	hat.self_modulate = _sec
	shield.self_modulate = _sec
