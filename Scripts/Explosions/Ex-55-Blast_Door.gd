extends Node2D

export(PackedScene) var pawn_part
export var trauma = 0.5

onready var anim = $AnimationPlayer
var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage1 = 1
var damage2 = 0
var damage_type = "Explosion"
var gun_num = 0

func _ready():
	pass

func init(_owner, _pos, _weap_name: int, _pawn_num, _dmg):
	self.global_position = _pos
	damage1 = (_dmg * .5)
	damage2 = _dmg
	var part1 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part1)
	part1.init(_owner, _pawn_num, 0, true, (_pos + Vector2(0, -30)), Vector2(-200, -200))
	var part2 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part2)
	part2.init(_owner, _pawn_num, 1, true, (_pos + Vector2(0, -10)), Vector2(200, -200))
	var part3 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part3)
	part3.init(_owner, _pawn_num, 2, true, (_pos + Vector2(0, 10)), Vector2(-200, -150))
	var part4 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part4)
	part4.init(_owner, _pawn_num, 3, true, (_pos + Vector2(0, 30)), Vector2(100, -200))
	owned = _owner
	anim.play("Explode")
	gun_num = _weap_name
	SFX.explosion(2)
	FX.add_trauma(trauma)

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func _on_Area2Douter_body_entered(body):
	if body.get_groups().has("hittable"):
		print_debug(body)
		body.hit(owned, gun_num, damage_type, damage1)

func _on_Area2D2inner_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, gun_num, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	call_deferred("free")
