extends Node2D

export(PackedScene) var boom

onready var anim = $AnimationPlayer

var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage1 = 50
var damage2 = 100
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

func boom_sec(_player):
	if _player:
		var _pos = _player.position
		var x = boom.instance()
		Map_Hand.add_kid_to_map(x)
		Player_Stats.add_hit(owned,1)
		x.init(owned, _pos, my_name, 0, damage1)

func _on_Area2Douter_body_entered(body):
	if body.get_groups().has("player"):
		call_deferred("boom_sec", body)

func _on_Area2D2inner_body_entered(body):
	if body.get_groups().has("player"):
		Player_Stats.add_hit(owned,1)
		body.hit(owned, str(weap_name, " ", my_name), damage_type, damage2)
	elif body.get_groups().has("hittable"):
		print("trying to call hit on something hittable ex-02")
		body.hit(owned, weap_name, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	call_deferred("free")

func kill_me():
	call_deferred("free")
