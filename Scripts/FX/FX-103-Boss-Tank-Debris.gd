extends RigidBody2D

export var expire = true
onready var sprite = $Sprite

func _ready():
#	print("im here debris FX 103")
	if expire:
		var time = rand_range(65.0,125.0)
		$Timer.wait_time = time
		$Timer.start()

func init(_color, _frame, _move, _position, _impulse):
#	print("im here debris FX 103 init called    pos----->", _position, position)
	sprite.frame = _frame
	sprite.self_modulate = _color
	if _move:
		self.position = _position
	self.apply_impulse(Vector2(),_impulse)

func _on_Timer_timeout():
	self.call_deferred("free")
