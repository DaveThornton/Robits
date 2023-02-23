extends Node2D

export(PackedScene) var pawn_part

export var trauma = 1.0

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
	part1.init(_owner, _pawn_num, 0, true, (_pos + Vector2(-2, -2)), Vector2(-200, -200))
	var part2 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part2)
	part2.init(_owner, _pawn_num, 1, true, (_pos + Vector2(2, -2)), Vector2(200, -200))
	var part3 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part3)
	part3.init(_owner, _pawn_num, 2, true, (_pos + Vector2(-2, 2)), Vector2(-200, -150))
	var part4 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part4)
#	get_tree().get_current_scene().add_kid_to_map(part4)
	part4.init(_owner, _pawn_num, 3, true, (_pos + Vector2(2, 2)), Vector2(100, -200))
	owned = _owner
	anim.play("Explode")
	weap_name = _weap_name
#	anim.play()
	SFX.play("EX_Pawn")
	FX.add_trauma(trauma)
#	FX.CAMERA.shake(.3, 25, 9)
	gun_num = _weap_name

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func _on_Area2Douter_body_entered(body):
	if body.get_groups().has("hittable"):
		print_debug(body)
		body.hit(owned, gun_num, damage_type, damage1)

func _on_Area2D2inner_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, str(gun_num, " ", my_name), damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	call_deferred("free")
