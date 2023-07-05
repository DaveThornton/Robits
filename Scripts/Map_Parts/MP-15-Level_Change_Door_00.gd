extends Node2D

onready var anim = $AnimationPlayer
onready var timer = $Timer

var world_to_load = 0
var map_to_load = 1
var bodies = []
var is_open = false

func load_map():
	bodies.clear()
	FX.CAMERA.reset()
	var map_w_info = Map_Hand.map.get_next_level_w_info (map_to_load)#0: next map number to load, 1: use spash ,  2: splash title , 3: splash body ,  4: lenght of splash in seconds
	var map_scene_to_load = Campaign.get_map(map_w_info[0], map_w_info[1])
	# Map_Hand.load_map_cam_first(map_scene_to_load, map_w_info[3], map_w_info[4], map_w_info[5], map_w_info[2])#_level, _label_1, _label_2, _time, _show):
	Map_Hand.load_map_cam(map_scene_to_load, map_w_info[3], map_w_info[4], map_w_info[5], map_w_info[2])#_level, _label_1, _label_2, _time, _show):
	call_deferred("queue_free")

func open():
	if anim.is_active() && anim.get_current_animation() != "Open":
		anim.queue("Open")
	elif !anim.is_active():
		anim.play("Open")
	print(anim.get_current_animation())

func close():
	anim.play("Close")

func set_open(open: bool):
	is_open = open

func set_map_to_load(num: int):
	map_to_load = num

func _on_Area2D_body_entered(body:Node):
	if body.get_groups().has("player") && !bodies.has(body):
		if is_open:
			call_deferred("load_map")
		else:
			bodies.append(body)
			if anim.is_playing():
				if anim.get_current_animation() == "Open":
					pass
				else:
					open()
			else:
				open()

func _on_Area2D_body_exited(body:Node):
	if bodies.find(body) >= 0:
		bodies.remove(bodies.find(body))

func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "Open":
		set_open(true)
		if bodies.size() > 0:
			print("more than nun ", bodies.size())
			call_deferred("load_map")
		else:
			timer.start()

func _on_AnimationPlayer_animation_started(anim_name:String):
	if anim_name == "Close":
		set_open(false)

func _on_Timer_timeout():
	close()
