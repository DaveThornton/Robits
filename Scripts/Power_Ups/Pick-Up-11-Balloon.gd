extends RigidBody2D

export(PackedScene) var popped

export var color_01 = Color8(255,255,255,255)
export var color_02 = Color8(255,255,255,255)
export var color_03 = Color8(255,255,255,255)

onready var balloon_sprite = $Balloon_Body/CollisionShape2D/Balloon
onready var balloon_body = $Balloon_Body
onready var rope_01 = $RigidBody2D
onready var rope_02 = $RigidBody2D2
onready var rope_03 = $RigidBody2D3
onready var rope_04 = $RigidBody2D4
onready var rope_05 = $RigidBody2D5
onready var rope_06 = $RigidBody2D6
onready var rope_07 = $RigidBody2D7
onready var rope_01_sprite = $RigidBody2D/CollisionShape2D/White_Pixel
onready var rope_02_sprite = $RigidBody2D2/CollisionShape2D/White_Pixel
onready var rope_03_sprite = $RigidBody2D3/CollisionShape2D/White_Pixel
onready var rope_04_sprite = $RigidBody2D4/CollisionShape2D/White_Pixel
onready var rope_05_sprite = $RigidBody2D5/CollisionShape2D/White_Pixel
onready var rope_06_sprite = $RigidBody2D6/CollisionShape2D/White_Pixel
onready var rope_07_sprite = $RigidBody2D7/CollisionShape2D/White_Pixel
onready var timer = $Timer
# onready var line = $Line2D

var is_popped = false
var player = 0
var popped_count = 1
var current_color = 1
var point_01
var tank_pos = 0

signal death
signal clear

func _ready():
	current_color = (randi() % 3) + 1
	if current_color == 1:
		color(color_01,Color8(255,255,255,255))
	elif current_color == 2:
		color(color_02,Color8(255,255,255,255))
	elif current_color == 3:
		color(color_03,Color8(255,255,255,255))
	point_01 = self.position

# func _process(_delta):
# 	if !is_popped:
# 		line.set_point_position(1, point_01)
# 		line.set_point_position(0,Vector2(balloon_body.position.x,balloon_body.position.y + 15))


func hit(_by_who, _by_what, _damage_type, _damage):
	pop()

func pop():
	if !is_popped:
		is_popped = true
		var x = popped.instance()
		self.get_tree().get_current_scene().add_child(x)
		x.global_position = balloon_body.global_position
		emit_signal("death", self)
		balloon_body.call_deferred("free")
		overweight()
		line_on(false)
		timer.start(0.2)
	elif popped_count == 1:
		rope_01.call_deferred("free")
		timer.start(0.3)
		popped_count += 1
	elif popped_count == 2:
		rope_02.call_deferred("free")
		timer.start(0.2)
		popped_count += 1
	elif popped_count == 3:
		rope_03.call_deferred("free")
		timer.start(0.3)
		popped_count += 1
	elif popped_count == 4:
		rope_04.call_deferred("free")
		timer.start(0.2)
		popped_count += 1
	elif popped_count == 5:
		rope_05.call_deferred("free")
		timer.start(0.3)
		popped_count += 1
	elif popped_count == 6:
		rope_06.call_deferred("free")
		timer.start(0.2)
		popped_count += 1
	elif popped_count == 7:
		rope_07.call_deferred("free")
		timer.start(0.3)
		popped_count += 1
		emit_signal("clear")
		self.call_deferred("free")
	else:
		emit_signal("clear")
		self.call_deferred("free")

func set_tank_pos(_num):
	pass
		
func get_tank_pos(_num):
	pass

func on_map():
	balloon_body.mass = 1.0
	balloon_body.gravity_scale = -10
	balloon_body.linear_damp = -1
	balloon_body.linear_velocity.y = 0
	balloon_body.applied_force.y = 0
	timer.start()
	line_on(false)

func on_player(_player):
	player = _player
	balloon_body.mass = 0.5
	balloon_body.gravity_scale = -10
	balloon_body.linear_damp = 4
	balloon_body.linear_velocity.y = -5000
	balloon_body.applied_force.y = -3000
	point_01 = Controllers.get_pawn(player).attachment_point.position
	line_on(true)
	timer.start()

func line_on(_on):
	rope_01_sprite.visible = !_on
	rope_02_sprite.visible = !_on
	rope_03_sprite.visible = !_on
	rope_04_sprite.visible = !_on
	rope_05_sprite.visible = !_on
	rope_06_sprite.visible = !_on
	rope_07_sprite.visible = !_on
	# line.visible = _on

func overweight():
	rope_01.gravity_scale = 5
	rope_02.gravity_scale = 5
	rope_03.gravity_scale = 5
	rope_04.gravity_scale = 5
	rope_05.gravity_scale = 5
	rope_06.gravity_scale = 5
	rope_07.gravity_scale = 5

	rope_01.mass = 50
	rope_02.mass = 50
	rope_03.mass = 50
	rope_04.mass = 50
	rope_05.mass = 50
	rope_06.mass = 50
	rope_07.mass = 50


func color(_pri, _sec):
	balloon_sprite.self_modulate = _pri

func get_color():
	return balloon_sprite.self_modulate

func _on_Timer_timeout():
	pop()
