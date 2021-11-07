extends StaticBody2D

func hit(_by_who, _by_what, _damage_type, _damage):
	get_parent().hit(_by_who, _by_what, _damage_type, _damage)
