extends RigidBody2D

var player = 0

func hit(_by_who, _by_what, _damage_type, _damage):
	self.get_parent().hit(_by_who, _by_what, _damage_type, _damage)