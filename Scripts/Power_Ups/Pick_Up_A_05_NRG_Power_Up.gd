extends 'res://Scripts/Power_Ups/Pick_Up_A_00.gd'

export var how_long = 12
export var how_much = 15

func _on_body_entered(body):
	if body.get_groups().has("player"):
		body.put_nrg_regen_speed_up(how_long, how_much)
		SFX.nrg()
		if respawn:
			r_timer.start()
			call_deferred("_disappear")
		else:
			call_deferred("free")