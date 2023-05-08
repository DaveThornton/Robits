extends RigidBody2D

export var how_much_nrg = 5
export var how_much_ammo = 2

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):pass
	
func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		body.add_coin(how_much_nrg)
		SFX.coin()
		call_deferred("free")

func dont_hit_player():pass