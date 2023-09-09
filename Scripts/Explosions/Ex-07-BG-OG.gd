extends Node2D

onready var anim = $AnimatedSprite

var part_num = 3

func _ready():
	pass

func init(_owner, _pos, _weap_name: int, _pawn_num, _dmg):
	self.global_position = _pos
	anim.playing = true
	var part = FX.get_misc_fx(part_num)
	var part1 = part.instance()
	Map_Hand.add_kid_to_map(part1)
	part1.init(0, 0, 0, true, (_pos + Vector2(-2, -2)), Vector2(-200, -200))
	var part2 = part.instance()
	Map_Hand.add_kid_to_map(part2)
	part2.init(0, 0, 1, true, (_pos + Vector2(2, -2)), Vector2(200, -200))
	var part3 = part.instance()
	Map_Hand.add_kid_to_map(part3)
	part3.init(0, 0, 2, true, (_pos + Vector2(-2, 2)), Vector2(-200, -150))
	var part4 = part.instance()
	Map_Hand.add_kid_to_map(part4)
	part4.init(0, 0, 3, true, (_pos + Vector2(2, 2)), Vector2(100, -200))
	SFX.explosion(2)
	print_debug("ex 07 bg needs its own SFX")

func _on_AnimatedSprite_animation_finished():
	call_deferred("queue_free")
