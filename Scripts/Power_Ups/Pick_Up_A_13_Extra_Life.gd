extends 'res://Scripts/Power_Ups/Pick_Up_A_00.gd'

export var lives = 1

func _on_body_entered(body):
	if body.get_groups().has("player"):
		Player_Stats.add_lives(body.get_player_num(), lives)
		print_debug("got an extra life")
		if respawn:
			r_timer.start()
			call_deferred("_disappear")
		else:
			call_deferred("free")