extends 'res://Scripts/Power_Ups/Pick_Up_R_00.gd'

export var how_much = 1

func _on_Area2D_body_entered(body):
		if body.get_groups().has("player"):
			if body.take_ammo:
				body.ammo_box(how_much)
				call_deferred("free")