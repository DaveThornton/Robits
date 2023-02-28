extends StaticBody2D

func _ready():
	pass # Replace with function body.

func hit(_by_who, _by_what, _damage_type, _damage):
	pass

func change_collision(_player_num: int):
	set_collision_layer_bit(Player_Stats.get_player_collision_layer(_player_num),true)