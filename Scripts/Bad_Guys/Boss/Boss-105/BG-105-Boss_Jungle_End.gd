extends Node2D

onready var anim = $AnimationPlayer
onready var hit_plate = $Top/Hit_Plate
onready var cannon_01 = $"Back/BG-105-Cannon_01"
onready var cannon_02 = $"Top/BG-105-Cannon_02"

func _ready():
	hit_plate.connect("dead",self,"dead")
	pass # Replace with function body.

#func _process(delta):
#	pass

func dead():
	anim.play("Dead")

func _on_Timer_timeout():
	cannon_01.shoot()
	cannon_02.shoot()