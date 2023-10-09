extends RigidBody2D

export var frame = -1

onready var anim = $AnimationPlayer

func _ready():
	if frame > 0:
		set_frame(frame)

func set_frame(num): #call_deferred("_set_frame",num)
# func _set_frame(num):
	match num:
		0:anim.play("Full")
		1:anim.play("Half")
		2:anim.play("Quarter")
		3:anim.play("Board")
		_:
			anim.play("Full")
			print_debug("error in FX 09 Log_Full wrong frame called setting to 0, tried to call ", num)

func warp_to(_pos): self.global_position = _pos + Vector2(0,-17)