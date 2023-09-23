extends Node2D

onready var anim = $AnimationPlayer
onready var hit_plate = $Top/Hit_Plate



func _ready():
	hit_plate.connect("dead",self,"dead")
	pass # Replace with function body.

#func _process(delta):
#	pass

func dead():
	anim.play("Dead")