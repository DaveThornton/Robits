extends Node2D

onready var anim = $AnimationPlayer
#onready var sfx = $SFX_Lib

#var hit_already = []
var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage1 = 50
var damage2 = 100
var damage_type = "Explosion"

#func _ready():
##	my_name = weap_name
#	pass

func init(_owner, _pos, _weap_name, _pawn_num, _dmg):
	print("init called on standard EX")
	damage1 = (_dmg * .5)
	damage2 = _dmg
	self.global_position = _pos
	owned = _owner
	anim.play("Explode")
	weap_name = _weap_name
	SFX.play("EX_Standard")

func start( _sr , _ss, _sss, _player):
#	_check_dir()
	owned = _player
	self.position = _ss

func _on_Area2Douter_body_entered(body):
	if body.get_groups().has("hittable"):
		body.hit(owned, weap_name, damage_type, damage1)

func _on_Area2D2inner_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, str(weap_name, " ", my_name), damage_type, damage2)
	elif body.get_groups().has("hittable"):
		print("trying to call hit on something hittable")
		body.hit(owned, weap_name, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	queue_free()
