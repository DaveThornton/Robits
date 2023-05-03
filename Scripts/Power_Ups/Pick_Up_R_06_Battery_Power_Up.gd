extends 'res://Scripts/Power_Ups/Pick_Up_R_00.gd'

export var how_much_nrg = 50

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if body.nrg != body.nrg_max:
			body.add_battery(how_much_nrg)
			SFX.battery()
			call_deferred("free")