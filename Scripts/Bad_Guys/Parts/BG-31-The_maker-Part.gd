extends KinematicBody2D

onready var anim = $AnimationPlayer

export var part_num = 0
var my_name = "The maker"
var dmg_type = "Worm"
var damage = 5000

func _ready():
	set_part(part_num)

func set_part_num(_num):
	part_num = _num
	# set_part(part_num)

func set_part(_num:int):
	if _num == 1:
		anim.play("Front")
	elif _num == 2:
		anim.play("Middle")
	elif _num == 3:
		anim.play("Back")
	else:
		print("error in BG 31 part invalid int in set part ", _num)

func move(_where:Vector2):
	move_and_slide(_where)
#func _process(delta):
#	pass


func _on_Area2D_body_entered(_body:Node):
	if _body.get_groups().has("player"):
		_body.hit(-1, my_name, dmg_type, damage)

