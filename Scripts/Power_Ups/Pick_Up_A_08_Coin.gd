extends 'res://Scripts/Power_Ups/Pick_Up_A_00.gd'

export var how_much_nrg = 12

func _on_body_entered(body):
	if body.get_groups().has("player"):
		body.add_coin(how_much_nrg)
		SFX.coin()	
		if respawn:
			r_timer.start()
			call_deferred("_disappear")
		else:
			call_deferred("free")