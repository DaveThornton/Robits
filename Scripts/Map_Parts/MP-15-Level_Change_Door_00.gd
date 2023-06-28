extends Node2D

onready var anim = $AnimationPlayer

var map_to_load = 1
var bodies = []
var is_open = false

func load_map():
	bodies.clear()
	FX.CAMERA.reset()
	var map_w_info = Map_Hand.map.get_next_level_w_info (map_to_load)#0: next map number to load, 1: use spash ,  2: splash title , 3: splash body ,  4: lenght of splash in seconds
	var map_scene_to_load = Campaign.get_map(map_w_info[0])
	Map_Hand.load_map_cam_first(map_scene_to_load, map_w_info[2], map_w_info[3], map_w_info[4], map_w_info[1])

func open():
	anim.play("Door-Open")

func close():
	anim.play("Door-Close")

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
				if anim.get_current_animaion() == "Open":
					pass
				else:
					anim.queue("Open")
			else:
				anim.play("Open")

func _on_Area2D_body_exited(body:Node):
	if bodies.find(body) >= 0:
		bodies.remove(bodies.find(body))

func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "Open":
		set_open(true)
		if bodies.size() > 0:
			call_deferred("load_map")
			# load_map()

func _on_AnimationPlayer_animation_started(anim_name:String):
	if anim_name == "Close":
		set_open(false)
