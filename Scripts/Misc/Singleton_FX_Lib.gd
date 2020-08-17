extends Node2D

onready var CAMERA = $"MP-01-Camera"

func add_trauma(_amount):
	CAMERA.add_trauma(_amount)
