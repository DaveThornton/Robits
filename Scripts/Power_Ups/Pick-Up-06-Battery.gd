extends RigidBody2D

export var how_much_nrg = 50

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	pass

func _on_Area2D_body_entered(body):
	print("body entered battery")
	if body.get_groups().has("player"):
		body.add_nrg(how_much_nrg)
		call_deferred("free")
