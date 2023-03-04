extends StaticBody2D

export var health = 100
onready var anim = $AnimationPlayer
var player = -1

func _ready():
	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= _damage
	if health <= 0:
		anim.play("Dead") 
	else:
		anim.queue("Hit")

func explode():
	FX.explode(55, -1, self.global_position, 0, 0, 0)