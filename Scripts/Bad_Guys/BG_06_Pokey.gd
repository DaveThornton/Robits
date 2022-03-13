extends KinematicBody2D

export(PackedScene) var pokey_part
export var my_color = Color(0,0,0,0)
export var how_many_parts = 5
export var start_left = true
export var set_speed = 10

onready var cast_left = $RayCast2D_Left
onready var cast_right = $RayCast2D_Riight
onready var cast_down = $RayCast2D_Down
onready var refresh_timer = $Timer

var speed = 10
var gravity = 200
var parts = []
var start_pos = -15
var part_space = -30
var going_left = true
var started = false
var time = 0

func _ready():
# 	call_deferred("now_ready")
# func now_ready():
	var pos = self.global_position.y + start_pos
	speed = set_speed
	for i  in how_many_parts:
		# print("spawning parts BG06", position)
		var part = pokey_part.instance()
		add_child(part)
		parts.append(part)
		part.start((i + 1), my_color, pos)
		pos -= 30
		var test = part.connect("distroyed", self, "hit")
		if test != 0:
			print("failed to connect distroyed to hit in pokey bg06")
	parts[-1].call_deferred("head")

	if start_left:
		going_left = true
	else:
		going_left = false
	call_deferred("set_started")

func _process(delta):
	if started:
		# print(self.global_position)
		var _down = 0
		var _dir = 0
		if cast_down.is_colliding():
			self.global_position = cast_down.get_collision_point()
			# if cast_down.get_collision_point() > self.global_position + Vector2(0,2):
			# 	self.global_position = cast_down.get_collision_point()
			# else:
			_down = 0
		else:
			_down = gravity * delta # .1
		
		if cast_left.is_colliding():
			going_left = false
		elif cast_right.is_colliding():
			going_left = true

		if going_left:
			_dir = -speed * delta
		else:
			_dir = speed * delta

		# var _test1 = self.move_and_slide(Vector2(_dir, 0))
		var _test2 = self.move_and_collide(Vector2(_dir,_down))

func set_started():
	started = true

func hit(_body):
	FX.explode(6, -1, _body.global_position, "BG_06 selfdistruct", 0, 0)
	# print(_body.global_position)
	parts.erase(_body)
	remove_child(_body)
	_body.call_deferred("free")
	refresh_timer.start()


func refresh():
	if parts.size() == 0:
		call_deferred("free")
	else:
		for i in parts.size():
			if i == 0:
				parts[i].set_pos(start_pos)
				parts[i].set_frame(0)
			else:
				parts[i].set_pos(start_pos + (i * part_space))
				# parts[i].move_pos(start_pos + (i * part_space))
				parts[i].set_frame((i + 2) % 2)
		print("im hit in bg 06 pokey im down a part")
		parts[-1].call_deferred("head")

func _on_Timer_timeout():
	refresh()
