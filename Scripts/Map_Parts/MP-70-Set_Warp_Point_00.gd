extends Node2D

export var warp_number = 1

onready var point = $Position2D

func _ready():
	pass

func setup(_warp_number):
	warp_number = _warp_number
	go()

func go(): Map_Hand.get_map().set_warp_point(warp_number,point.global_position)
