extends Area2D
export var lives = 1


onready var shape = $CollisionShape2D
onready var dot = $Sprite

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	pass

func _on_Jump_Power_Up_body_entered(body):
	if body.get_groups().has("player"):
		if !body.is_jump_up:
			Player_Stats.add_lives(body.get_player_num(), lives)
			print_debug("got an extra life")
			_disappear()

func _disappear():
	call_deferred("queue_free")
	# dot.visible = false 
	# shape.disabled = true 
