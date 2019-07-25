extends StaticBody2D

export(PackedScene) var brick_explode
export(PackedScene) var head_explode

export var frame = 0
export var head_hit = false
export var respawn = true
export var respawn_time = 30.0

onready var sprite = $Basic_Red_set
onready var head_area = $Area2D/CollisionShape2D
onready var kill_timer= $Timer
onready var respawn_timer = $Timer_respawn
onready var box_shape = $CollisionShape2D
onready var sfx = $SFX_Lib

var pos
# warning-ignore:unused_class_variable
var player = 9

func _ready():
	if frame == 0:
		sprite.frame = 49
	elif frame == 1: 
		sprite.frame = 50
#	else:
#	elif frame == 2: 
#		sprite.frame = 2
#	elif frame == 3: 
#		sprite.frame = 3
#	elif frame == 4: 
#		sprite.frame = 4
#	elif frame == 5: 
#		sprite.frame = 5
#	elif frame == 6: 
#		sprite.frame = 6
#	elif frame == 7: 
#		sprite.frame = 7
#	elif frame == 8: 
#		sprite.frame = 8
#	elif frame == 9: 
#		sprite.frame = 9
#	elif frame == 10: 
#		sprite.frame = 10
#	elif frame == 11: 
#		sprite.frame = 11
#	elif frame == 12: 
#		sprite.frame = 12
#	elif frame == 13: 
#		sprite.frame = 13
#	elif frame == 14: 
#		sprite.frame = 14
#	elif frame == 15: 
#		sprite.frame = 15
#	elif frame == 16: 
#		sprite.frame = 16
#	elif frame == 17: 
#		sprite.frame = 17
#	elif frame == 18: 
#		sprite.frame = 18
#	else:
		print("error : in mp-40-distruct-brick-40 bad frame number")
	if head_hit:
		head_area.disabled = false
	if respawn:
		respawn_timer.wait_time = respawn_time
#warning-ignore:unused_argument
#warning-ignore:unused_argument
#warning-ignore:unused_argument
func hit(_owned, my_name, damage_type, damage):
	call_deferred("_hit",_owned, my_name, damage_type, damage)
func _hit(_owned, my_name, damage_type, damage):
	sfx.play("EX_Brick")
#	print("hit bricks")
	var e = brick_explode.instance()
	var h = head_explode.instance()
	pos = self.global_position
#	call_deferred("_add_to_top_parent", e)
#	call_deferred("_add_to_top_parent", h)
	get_tree().get_current_scene().add_child(h)
	get_tree().get_current_scene().add_child(e)
	e.init(_owned, pos)
	h.init(_owned, pos, my_name, 0, damage)
#	var h = head_explode.instance()
#	get_tree().get_current_scene().add_child(h)
#	h.init(_owned, pos)
#	call_deferred("free")#queue_free()
	kill_timer.start()

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
#		var h = head_explode.instance()
#		get_tree().get_current_scene().add_child(h)
##		print(pos,"distruct-brick")
#		var pos = self.global_position
#		h.init(0, pos)
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
