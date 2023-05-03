extends 'res://Scripts/Power_Ups/Pick_Up_R_00.gd'

export var how_long = 12

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if !body.is_speed_up:
			body.put_speed_up(how_long)
			SFX.speed()
			call_deferred("free")