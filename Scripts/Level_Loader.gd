extends Node2D

onready var splash = $Level_Load_Screen
onready var timer = $Timer

func load_level(_level, _label_1, _label_2, _time):
	splash.change_text(_label_1, _label_2)
	splash.visible = true

	var m = _level.instance()
	get_parent().add_child(m)
	get_parent().map.call_deferred("free")
	get_parent().map = m
	var e = get_parent().connect("reset",m,"reset")
	if !e:
		print("error in level loader: error connecting reset")
	timer.wait_time = _time
	timer.start()
	for p in get_tree().get_current_scene().pawns.get_children():
		p.position = m.player_spawns.get_child(m.next_spawn_spot).position
		m.next_spawn_spot += 1

func _on_Timer_timeout():
	get_tree().paused = false
	splash.visible = false
