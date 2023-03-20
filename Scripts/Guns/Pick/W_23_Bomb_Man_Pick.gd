extends 'res://Scripts/Guns/Pick/W_00_Bomb_Pick.gd'

func hit(_owned, _my_name, _damage_type, _damage1):
	player =  _owned
	arm()

func call_if_armed(): 
	anim.play("Armed")
	anim.seek(my_time - time, true)

func call_end_of_set_dir():
	if is_right:
		pass
	else:
		self.scale.y = -1