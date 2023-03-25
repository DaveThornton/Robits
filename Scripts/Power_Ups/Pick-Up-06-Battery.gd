extends RigidBody2D

export var how_much_nrg = 50

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	pass

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if body.nrg != body.nrg_max:
			body.add_battery(how_much_nrg)
			SFX.battery()
			call_deferred("free")

func dont_hit_player():
	pass
