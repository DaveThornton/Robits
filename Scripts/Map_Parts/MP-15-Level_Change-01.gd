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
var bodies = []

func off():
	exit_shape.disabled = true
#	print("--------------------------------exitshape --->",exit_shape.disabled)

func on():
	exit_shape.disabled = false
#	print("--------------------------------exitshape --->",exit_shape.disabled)

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		print("body entered in area 1 ")
		if bodies.find(body) >= 0:
			print("entered 1 already in bodies mp15", bodies.size())
			go()
		else:
			print("entered 1 appending in bodies mp15", bodies.size())
			bodies.append(body)
	# if body.get_groups().has("player"):
	# 	get_tree().paused = true
	# 	anim.play("Door-Open-Close")
	# 	print("pause")

func _on_Area2D_body_exited(body):
	if bodies.find(body) >= 0:
		bodies.remove(bodies.find(body))

func _on_Area2D2_body_entered(body):
	if body.get_groups().has("player"):
		print("body entered in area 2 ")
		if bodies.find(body) >= 0:
			print("entered 2 already in bodies mp15", bodies.size())
			go()
		else:
			print("entered 2 appending in bodies mp15", bodies.size())

func _on_Area2D2_body_exited(body):
	if bodies.find(body) >= 0:
		bodies.remove(bodies.find(body))

func go():
	get_tree().paused = true
	anim.play("Door-Open-Close")
	print("pause in go on mp 15 door thing")

func _on_AnimationPlayer_animation_finished(anim_name):
	FX.CAMERA.reset()
	if anim_name == "Door-Open-Close":
		if !load_random:
			if load_level_1:
				_load_level(level_to_load_1, text_title_1, text_body_1, splash_time_1, show_splash_1)
			else:
				_load_level(level_to_load_2, text_title_2, text_body_2, splash_time_2, show_splash_2)
		else:
			randomize()
			var l = rand_range(0,100)
			if l < chance_to_load_1:
				_load_level(level_to_load_1, text_title_1, text_body_1, splash_time_1, show_splash_1)
			else:
				_load_level(level_to_load_2, text_title_2, text_body_2, splash_time_2, show_splash_2)

func _load_level(_level_to_load,_text_title, _text_body, _splash_time, _show):
	Map_Hand.load_map_cam(_level_to_load, _text_title, _text_body, _splash_time, _show)
