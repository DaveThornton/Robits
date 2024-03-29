extends Node2D

export var trauma = 0.5

onready var anim = $AnimationPlayer

var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage1 = 10
var damage2 = 20
var damage_type = "Explosion"
var gun_num = 0

func init(_owner, _pos, _weap_name: int, _pawn_num, _dmg):
	damage1 = (_dmg * .5)
	damage2 = _dmg
	self.global_position = _pos
	owned = _owner
	anim.play("Explode")
	gun_num = _weap_name
	SFX.explosion(2)
	# SFX.play("EX_Standard")
	FX.add_trauma(trauma)

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func _on_Area2Douter_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, gun_num, damage_type, damage2)
	elif body.get_groups().has("hittable"):
		body.hit(owned, gun_num, damage_type, damage1)

func _on_Area2D2inner_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, gun_num, damage_type, damage2)
	elif body.get_groups().has("hittable"):
		body.hit(owned, gun_num, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	call_deferred("free")
