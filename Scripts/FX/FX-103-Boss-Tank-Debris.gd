extends RigidBody2D

export var expire = true
onready var sprite = $Sprite

func _ready():
	if expire:
		var time = rand_range(65.0,125.0)
		$Timer.wait_time = time
		$Timer.start()

func init(_color, _move, _pos, _impulse):
	sprite.self_modulate = _color
	if _move:
		self.position = _pos
	self.apply_impulse(Vector2(),_impulse)

func _on_Timer_timeout():
	self.call_deferred("free")
