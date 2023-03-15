extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

var walk_count = 0

func _process(delta):
	if walk_count == 0:
		if walk > 0.0:
			walk -= delta * 10
		elif walk < 0.0:
			walk += delta * 10

func shoot_j():
	_fire()

func empty():
	throw()
	Controllers.get_pawn(player).no_gun()
	# get_parent().no_gun()

func walk_where():
	walk_count += 1
	if walk_count  == 0:
		return walk_amount * 3
	elif walk_count  == 1:
		return -walk_amount * 2
	elif walk_count  == 2:
		return -walk_amount * 1.5
	elif walk_count  == 3:
		return walk_amount * 2
	elif walk_count  == 4:
		return -walk_amount * 3
	elif walk_count  == 5:
		return 0
	elif walk_count  == 6:
		return walk_amount
	elif walk_count  == 7:
		return -walk_amount * 2
	elif walk_count  == 8:
		walk_count = -1
		return walk_amount * 2.2
