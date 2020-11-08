extends Node2D

onready var anim = $AnimationPlayer

var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage1 = 10
var damage2 = 20
var damage_type = "Explosion"

func init(_owner, _pos, _weap_name, _pawn_num, _dmg):
	damage1 = (_dmg * .5)
	damage2 = _dmg
	self.global_position = _pos
	owned = _owner
	anim.play("Explode")
	weap_name = _weap_name
	SFX.play("EX_Standard")
	FX.add_trauma(2)

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func _on_Area2Douter_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, str(weap_name, " ", my_name), damage_type, damage2)
	elif body.get_groups().has("hittable"):
		body.hit(owned, weap_name, damage_type, damage1)

func _on_Area2D2inner_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, str(weap_name, " ", my_name), damage_type, damage2)
	elif body.get_groups().has("hittable"):
		body.hit(owned, weap_name, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	queue_free()
