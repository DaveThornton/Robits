extends Area2D

onready var glass = $Window_01_Glass
onready var shape = $CollisionShape2D

var dead = false

func _ready():
	pass # Replace with function body.

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		glass.frame = 7
		dead = true
		call_deferred("set_shape_disabled",true)

func set_shape_disabled(_disabled):
	shape.disabled = _disabled
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
