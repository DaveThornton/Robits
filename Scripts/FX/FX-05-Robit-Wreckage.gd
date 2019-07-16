extends RigidBody2D

#export var part_num = 0
export var expire = true
onready var shape1 = $CollisionShape2D_1
onready var shape2 = $CollisionShape2D_2
onready var shape3 = $CollisionShape2D_3
onready var shape4 = $CollisionShape2D_4
onready var sprite = $Sprite

func _ready():
	if expire:
		var time = rand_range(25.0,35.0)
		$Timer.wait_time = time
		$Timer.start()
#	init(1, 1, part_num, false, Vector2(0,0), Vector2(0,0))

func init(_player, _pawn, _part_num, _move, _pos, _impulse):
	if _player == 1:
		if _pawn == 1:
			if _part_num == 0:
				shape1.disabled = false
				sprite.frame = 0
			elif _part_num == 1:
				shape2.disabled = false
				sprite.frame = 1
			elif _part_num == 2:
				shape3.disabled = false
				sprite.frame = 2
			elif _part_num == 3:
				shape4.disabled = false
				sprite.frame = 3
			else:
				print("error in FX-05-Robit-Wreckage wrong part number called")
		else:
			print("error in FX-05-Robit-Wreckage wrong pawn number called")
	elif _player == 2:
		if _pawn == 1:
			if _part_num == 0:
				shape1.disabled = false
				sprite.frame = 4
			elif _part_num == 1:
				shape2.disabled = false
				sprite.frame = 5
			elif _part_num == 2:
				shape3.disabled = false
				sprite.frame = 6
			elif _part_num == 3:
				shape4.disabled = false
				sprite.frame = 7
			else:
				print("error in FX-05-Robit-Wreckage wrong part number called")
		else:
			print("error in FX-05-Robit-Wreckage wrong pawn number called")
	elif _player == 3:
		if _pawn == 1:
			if _part_num == 0:
				shape1.disabled = false
				sprite.frame = 8
			elif _part_num == 1:
				shape2.disabled = false
				sprite.frame = 9
			elif _part_num == 2:
				shape3.disabled = false
				sprite.frame = 10
			elif _part_num == 3:
				shape4.disabled = false
				sprite.frame = 11
			else:
				print("error in FX-05-Robit-Wreckage wrong part number called")
		else:
			print("error in FX-05-Robit-Wreckage wrong pawn number called")
	elif _player == 4:
		if _pawn == 1:
			if _part_num == 0:
				shape1.disabled = false
				sprite.frame = 12
			elif _part_num == 1:
				shape2.disabled = false
				sprite.frame = 13
			elif _part_num == 2:
				shape3.disabled = false
				sprite.frame = 14
			elif _part_num == 3:
				shape4.disabled = false
				sprite.frame = 15
			else:
				print("error in FX-05-Robit-Wreckage wrong part number called")
		else:
			print("error in FX-05-Robit-Wreckage wrong pawn number called")
	elif _player == 5:
		if _pawn == 1:
			if _part_num == 0:
				shape1.disabled = false
				sprite.frame = 16
			elif _part_num == 1:
				shape2.disabled = false
				sprite.frame = 17
			elif _part_num == 2:
				shape3.disabled = false
				sprite.frame = 18
			elif _part_num == 3:
				shape4.disabled = false
				sprite.frame = 19
			else:
				print("error in FX-05-Robit-Wreckage wrong part number called")
		else:
			print("error in FX-05-Robit-Wreckage wrong pawn number called")
	elif _player == 6:
		if _pawn == 1:
			if _part_num == 0:
				shape1.disabled = false
				sprite.frame = 20
			elif _part_num == 1:
				shape2.disabled = false
				sprite.frame = 21
			elif _part_num == 2:
				shape3.disabled = false
				sprite.frame = 22
			elif _part_num == 3:
				shape4.disabled = false
				sprite.frame = 23
			else:
				print("error in FX-05-Robit-Wreckage wrong part number called")
		else:
			print("error in FX-05-Robit-Wreckage wrong pawn number called")
	elif _player == 7:
		if _pawn == 1:
			if _part_num == 0:
				shape1.disabled = false
				sprite.frame = 24
			elif _part_num == 1:
				shape2.disabled = false
				sprite.frame = 25
			elif _part_num == 2:
				shape3.disabled = false
				sprite.frame = 26
			elif _part_num == 3:
				shape4.disabled = false
				sprite.frame = 27
			else:
				print("error in FX-05-Robit-Wreckage wrong part number called")
		else:
			print("error in FX-05-Robit-Wreckage wrong pawn number called")
	elif _player == 8:
		if _pawn == 1:
			if _part_num == 0:
				shape1.disabled = false
				sprite.frame = 28
			elif _part_num == 1:
				shape2.disabled = false
				sprite.frame = 29
			elif _part_num == 2:
				shape3.disabled = false
				sprite.frame = 30
			elif _part_num == 3:
				shape4.disabled = false
				sprite.frame = 31
			else:
				print("error in FX-05-Robit-Wreckage wrong part number called")
		else:
			print("error in FX-05-Robit-Wreckage wrong pawn number called")
	elif _player == 9:
		if _pawn == 1:
			if _part_num == 0:
				shape1.disabled = false
				sprite.frame = 32
			elif _part_num == 1:
				shape2.disabled = false
				sprite.frame = 33
			elif _part_num == 2:
				shape3.disabled = false
				sprite.frame = 34
			elif _part_num == 3:
				shape4.disabled = false
				sprite.frame = 35
			else:
				print("error in FX-05-Robit-Wreckage wrong part number called")
		else:
			print("error in FX-05-Robit-Wreckage wrong pawn number called")
	else:
		print("error in FX-05-Robit-Wreckage wrong player number called")
	if _move:
		self.position = _pos
	self.apply_impulse(Vector2(),_impulse)

func _on_Timer_timeout():
	self.call_deferred("free")