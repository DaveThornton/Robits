extends 'res://Scripts/Power_Ups/Pick_Up_A_00.gd'

export var how_much = 1

func _on_body_entered(body):
	if body.get_groups().has("player"):
			if body.take_ammo:
				body.ammo_box(how_much)
				if respawn:
					r_timer.start()
					call_deferred("_disappear")
				else:
					call_deferred("free")