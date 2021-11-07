extends RigidBody2D

export var expire = true
onready var sprite = $Sprite

func _ready():
	if expire:
		var time = rand_range(65.0,125.0)
		$Timer.wait_time = time
		$Timer.start()

func init(_player, _pawn, _part_num, _move, _pos, _impulse):
	if _part_num == 1:
		sprite.frame = 2
	elif _part_num == 2:
		sprite.frame = 5
	elif _part_num == 3:
		sprite.frame = 8
	elif _part_num == 4:
		sprite.frame = 11
	elif _part_num == 5:
		sprite.frame = 14
	elif _part_num == 6:
		sprite.frame = 17
	if _move:
		self.position = _pos
	self.apply_impulse(Vector2(),_impulse)

func _on_Timer_timeout():
	self.call_deferred("free")
