extends Node2D

export (PackedScene) var level_to_load_1
export var show_splash_1 = true
export var text_title_1 = "Level Title"
export var text_body_1 = "Body of text discribing the next level"
export var splash_time_1 = 3
export var load_level_1 = true
export var load_random = false
export var chance_to_load_1 = 50.0
export (PackedScene) var level_to_load_2 
export var show_splash_2 = true
export var text_title_2 = "Level Title  2"
export var text_body_2 = "Body of text discribing the next level 2"
export var splash_time_2 = 3
onready var exit_shape = $Area2D/CollisionShape2D
onready var anim = $AnimationPlayer
onready var open_timer = $Timer

#if you want to activate something and not load level like map select screen thing
export var activate_no_level = false
export var activate_no_level_num = 10

var bodies = []
var is_open = false

func off():
	exit_shape.disabled = true
#	print_debug("--------------------------------exitshape --->",exit_shape.disabled)

func on():
	exit_shape.disabled = false
#	print_debug("--------------------------------exitshape --->",exit_shape.disabled)

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if is_open:
			go()
		else:
			open()

func _on_Area2D_body_exited(body):
	if bodies.find(body) >= 0:
		bodies.remove(bodies.find(body))

func open():
	anim.play("Door-Open")

func close():
	is_open = false
	anim.play("Door-Close")

func go():
	bodies.clear()
	FX.CAMERA.reset()
	if !load_random && !activate_no_level:
		if load_level_1:
			_load_level(level_to_load_1, text_title_1, text_body_1, splash_time_1, show_splash_1)
		else:
			_load_level(level_to_load_2, text_title_2, text_body_2, splash_time_2, show_splash_2)
	elif load_random && !activate_no_level:
		randomize()
		var l = rand_range(0,100)
		if l < chance_to_load_1:
			_load_level(level_to_load_1, text_title_1, text_body_1, splash_time_1, show_splash_1)
		else:
			_load_level(level_to_load_2, text_title_2, text_body_2, splash_time_2, show_splash_2)
	else:
		Map_Hand.map.activate_BG(activate_no_level_num, null)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Door-Open":
		if bodies.size() > 0:
			go()
		else:
			is_open = true
	elif anim_name == "Door-Close":
		is_open = false
	else:
		print("animation played that shouldnt have in mp 15 01 dont know why but it shouldnt")

func _load_level(_level_to_load,_text_title, _text_body, _splash_time, _show):
	call_deferred("d_load_level",_level_to_load,_text_title, _text_body, _splash_time, _show)
	
func d_load_level(_level_to_load,_text_title, _text_body, _splash_time, _show):
	Map_Hand.load_map_cam(_level_to_load, _text_title, _text_body, _splash_time, _show)


func _on_Timer_timeout():
	close()

