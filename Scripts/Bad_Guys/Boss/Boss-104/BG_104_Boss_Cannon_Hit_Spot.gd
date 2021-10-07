extends KinematicBody2D

func _ready():
	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	self.get_parent().hit(_by_who, _by_what, _damage_type, _damage)