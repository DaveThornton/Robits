extends 'res://Scripts/Power_Ups/Pick_Up_R_00.gd'

export var how_much = 15
export var how_long = 10

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		body.put_nrg_regen_speed_up(how_long, how_much)
		SFX.nrg()
		call_deferred("free")