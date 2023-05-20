extends Node2D
export var hit_on_second = 1
export var count_to_second = 4
export var trigger_on_prox = false

onready var cast_down = $RayCast2D
onready var cast_up1 = $KinematicBody2D/RayCast2D_Up
onready var cast_up2 = $KinematicBody2D/RayCast2D_Up2
onready var cast_up3 = $KinematicBody2D/RayCast2D_Up3
onready var cast_up4 = $KinematicBody2D/RayCast2D_Up4
onready var hammer = $KinematicBody2D
onready var bottom = $"Area2D-Bottom"
onready var trigger_shape = $"Area2D-Bottom/Area2D-Trigger/CollisionShape2D"
onready var timer = $Timer
onready var sprite = $KinematicBody2D/Sprite

var current_count = 0
var slamming = false
var speed_down = 2000.0
var speed_up = -2000.0
var start_x = 0.0
var first = true

func _ready():
	# start_x = global_position.x
	if !trigger_on_prox:
		var con = self.get_tree().get_current_scene().connect("second", self, "second")
		if con != 0:
			print_debug("error on connecting second to second in Thwomp")
		trigger_shape.disabled = !trigger_on_prox
	cast_down.force_raycast_update()
	if cast_down.is_colliding():
		bottom.global_position = cast_down.get_collision_point()

func _process(delta):
	if first:
		first = false
		start_x = global_position.x
	var cposx = hammer.global_position.x - start_x
	if slamming:
		hammer.move_and_collide(Vector2(-cposx, speed_down * delta))
#		hammer.move_and_slide(Vector2(-cposx, speed_down * delta))
	else:
		hammer.move_and_collide(Vector2(-cposx, speed_up * delta))
		if cast_up1.is_colliding():
			print_debug("up-colliding")
			hit_it(cast_up1.get_collider())
		elif cast_up2.is_colliding():
			print_debug("up-colliding")
			hit_it(cast_up2.get_collider())
		elif cast_up3.is_colliding():
			print_debug("up-colliding")
			hit_it(cast_up3.get_collider())
		elif cast_up4.is_colliding():
			print_debug("up-colliding")
			hit_it(cast_up4.get_collider())

func slam():
	slamming = true
	sprite.frame = 1


func hit_it(_body):
	if _body.get_groups().has("player"):
		_body.killed_by_map(-1, 0, "map", 0)
	if _body.get_groups().has("hittable"):
		_body.hit(-1, "Thowmp", "Impact", 1000)

func second():
	current_count += 1
	if current_count == hit_on_second:
		slam()
	else:
		slamming = false
		sprite.frame = 0
	if current_count >= count_to_second:
		current_count = 0

func _on_Timer_timeout():
	slamming = false
	sprite.frame = 0

func _on_Area2DThuwmp_body_entered(body):
	if slamming:
		hit_it(body)

func _on_Area2DTrigger_body_entered(body):
	if body.get_groups().has("player"):
		slam()
		timer.start()
