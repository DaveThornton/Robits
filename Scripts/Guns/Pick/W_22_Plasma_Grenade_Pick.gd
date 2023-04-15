extends 'res://Scripts/Guns/Pick/W_00_Bomb_Pick.gd'

var detonator

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	player = _player
	if _ammo  == 0:
		ammo = 0

func add_det(_det):
	detonator = _det
	self.add_child(detonator)
	detonator.connect("blowed_up",self ,"blowing_up")

func blowing_up():
	call_deferred("queue_free")

func _on_Area2D_body_entered(body):
	if ammo == 0 && body.get_groups().has("player"):
		self.remove_child(detonator)
		body.attachment_point.attach(detonator)
		print_debug("hit person")
		call_deferred("free")
