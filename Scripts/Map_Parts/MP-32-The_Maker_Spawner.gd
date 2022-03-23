extends Area2D


export(PackedScene) var the_maker
export var going_right = false
export var only_once = true
export var if_not_one_time_sec = 7.0
export var wait_for_camera = true

onready var sprite = $"Mp-32-MakerSpawn"
onready var timer = $Timer

var spawn = true
var once = true

func _ready():
	sprite.visible = false
	if !only_once && !wait_for_camera:
		timer.wait_time = if_not_one_time_sec
		timer.start()
	elif !wait_for_camera:
		triggered()
	# else:
	# 	print("error in mp 32 maker spawner invalid "

func triggered():
	print("triggered in mp 32 the makeer spawner")
	if spawn && timer.is_stopped():
		spawn_worm()


func spawn_worm():

	if spawn:
		if only_once:
			spawn = false
		else:
			if timer.is_stopped():
				timer.start()
		var new_mk = the_maker.instance()
		Map_Hand.add_bg_to_map(new_mk)
		new_mk.global_position = self.global_position
		new_mk.call_deferred("set_going_right", going_right)

func _on_Timer_timeout():
	triggered()
