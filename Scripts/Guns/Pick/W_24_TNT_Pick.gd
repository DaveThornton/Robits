extends 'res://Scripts/Guns/Pick/W_00_Bomb_Pick.gd'

func call_if_armed(): 
	anim.play("Armed")
	anim.seek(my_time - time, true)