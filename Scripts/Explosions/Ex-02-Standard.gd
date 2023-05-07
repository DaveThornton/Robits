extends Node2D

export var trauma = 0.5

onready var anim = $AnimationPlayer

var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage1 = 50
var damage2 = 100
var damage_type = "Explosion"
var gun_num = 0

func init(_owner, _pos, _weap_name: int, _pawn_num, _dmg):
	damage1 = (_dmg * .5)
	damage2 = _dmg
	self.global_position = _pos
	owned = _owner
	anim.play("Explode")
	weap_name = _weap_name
	SFX.play("EX_Standard")
	FX.add_trauma(trauma)
	gun_num = _weap_name

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func _on_Area2Douter_body_entered(body):
	pass
	# if body.get_groups().has("player"):
	# 	Player_Stats.add_hit(owned,1)
	# 	body.hit(owned, gun_num, damage_type, damage2)
	# elif body.get_groups().has("hittable"):
	# 	body.hit(owned, gun_num, damage_type, damage1)

func _on_Area2D2inner_body_entered(body):
	pass
	# if body.get_groups().has("player"):
	# 	Player_Stats.add_hit(owned,1)
	# 	body.hit(owned, gun_num, damage_type, damage2)
	# elif body.get_groups().has("hittable"):
	# 	print_debug("trying to call hit on something hittable ex-02")
	# 	body.hit(owned, gun_num, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	call_deferred("free")
