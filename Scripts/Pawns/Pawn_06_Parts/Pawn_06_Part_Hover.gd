extends Node2D

onready var part = $CPUParticles2D


func _ready():
	part.angle = 90

func right():
	part.angle = -20

func left():
	part.angle = 20

func center():
	part.angle = 0