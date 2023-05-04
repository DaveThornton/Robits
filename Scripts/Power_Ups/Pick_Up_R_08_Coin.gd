extends 'res://Scripts/Power_Ups/Pick_Up_R_00.gd'

export var how_much_nrg = 5
export var how_much_ammo = 0

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		body.add_coin(how_much_nrg,how_much_ammo)
		SFX.coin()
		call_deferred("free")