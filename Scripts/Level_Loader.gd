extends Node2D

onready var splash = $"Menu-Map_load-Backround"
onready var label_title = $"Menu-Map_load-Backround/Label"
onready var label_body = $"Menu-Map_load-Backround/Label2"
onready var timer = $Timer

func load_level(_level, _label_1, _label_2, _time):
	splash.visible = true
	label_title.text = _label_1
	label_body.text = _label_2
	var m = _level.instance()
	get_parent().add_child(m)
	get_parent().map.call_deferred("free")
	get_parent().map = m
	var e = get_parent().connect("reset",m,"reset")
	if !e:
		print("error in level loader: error connecting reset")
#	get_parent().map.call_deferred("free")
#	get_parent().map = m
	timer.wait_time = _time
	timer.start()
	for p in get_tree().get_current_scene().pawns.get_children():
#		print("kids?")
#		print(m.next_spawn_spot)
#		print(p)
		p.position = m.player_spawns.get_child(m.next_spawn_spot).position
		m.next_spawn_spot += 1

func _on_Timer_timeout():
	get_tree().paused = false
	splash.visible = false
