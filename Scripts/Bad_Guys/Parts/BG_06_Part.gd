extends KinematicBody2D

onready var sprite = $Sprite
onready var anim = $AnimationPlayer
export var points = 1

var body = 0
var health = 10
var player = 0
var body_num = 0
var color = Color(255,255,255,255)
var pos = 15
var my_name = "Pokey"
var dmg_type = "sharp"
var damage = 500
var my_pos = 0
var time = 1.0
var elasped = 0.0

signal distroyed

func _process(_delta):
	pass
	# elasped += _delta
	# if elasped >= time:
	# 	if self.position.y != my_pos:
	# 		var move = ceil(self.global_position.y + my_pos)
	# 		self.position.y += move
	# 	elasped = 0.0


func start(_body_num,_color, _pos):
	body_num = _body_num
	color = _color
	self.global_position.y = _pos
	my_pos = _pos
	pos = _pos
	# print_debug(global_position)
	call_deferred("starting",_body_num,_color, _pos)

func starting(_body_num,_color, _pos):
	if _body_num < 3:
		sprite.frame = _body_num
		body = _body_num
	else:
		body = 1 
		sprite.frame = body
	if (_body_num + 1) % 2 == 1:
		anim.play("start_left")
	else:
		anim.play("start_right")

	sprite.modulate = _color
	# print_debug(self.global_position)

func move_pos(_pos):
	my_pos = _pos

func set_pos(_pos):
	self.position.y = _pos

func set_frame(_frame):
	if _frame == 1:
		anim.play("start_left")
	else:
		anim.play("start_right")
	sprite.frame = _frame

func head():
	if (body +1) % 2 == 1:
		sprite.frame = 3
	else:
		sprite.frame = 4

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= _damage
	if health <= 0:
		Player_Stats.add_score(_by_who, points)
		print_debug("bg 06 part distroyed ")
		emit_signal("distroyed", self)

func _on_BG_06_Part_Damage_area_body_entered(_body:Node):
	if _body.get_groups().has("player"):
		_body.hit(-1,206, dmg_type, damage)
