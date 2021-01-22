extends Node2D

export(PackedScene) var platform
export var spawn_time = 4
export var plat_time = 4
export var speed = 75

onready var sprite = $Sprite
onready var timer = $Timer

func _ready():
	timer.wait_time = spawn_time
	timer.start()
#	sprite.visible = false

func _on_Timer_timeout():
	var plat = platform.instance()
	Map_Hand.add_kid_to_map(plat)
	plat.global_position = self.global_position
	plat.start(plat_time, speed)
