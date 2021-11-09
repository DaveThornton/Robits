extends StaticBody2D

export(PackedScene) var bricks

export var frame = 0
export var head_hit = false
export var respawn = true
export var respawn_time = 30.0
export var is_custom_color = false
export var brick_color = 1 #1:Red   /   2:Blue   /   3:Yellow    / 4:Green
export var custom_color = Color(255,255,255,255)

onready var sprite = $Sprite
onready var head_area = $Area2D/CollisionShape2D
onready var kill_timer= $Timer
onready var respawn_timer = $Timer_respawn
onready var box_shape = $CollisionShape2D

var my_color = Color(255,255,255,255)
var pos
var player = -1

func _ready():
	call_deferred("set_my_start_color")
	if head_hit:
		head_area.disabled = false
	if respawn:
		respawn_timer.wait_time = respawn_time

func hit(owned, my_name, damage_type, damage):
	call_deferred("_hit",owned, my_name, damage_type, damage)

func _hit(_owned, _my_name, _damage_type, _damage):
	FX.four_brick(_owned, self.global_position, my_color)
	FX.explode(11, _owned, self.global_position, _my_name, -1, _damage)
	kill_timer.start()

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		hit(0, "head", "head",100)

func _init_this(_owner, _thing):
	get_tree().get_current_scene().add_child(_thing)
	_thing.init(_owner, pos)

func _on_Timer_timeout():
	if respawn:
		sprite.visible = false 
		box_shape.disabled = true
		head_area.disabled = true
		respawn_timer.start()
	else:
		call_deferred("free")

func _on_Timer_respawn_timeout():
		sprite.visible = true
		box_shape.disabled = false
		if head_hit:
			head_area.disabled = false

func set_my_start_color():
	if !is_custom_color:
		my_color = FX.get_brick_color(brick_color)
	else:
		my_color = custom_color
	sprite.self_modulate = my_color
