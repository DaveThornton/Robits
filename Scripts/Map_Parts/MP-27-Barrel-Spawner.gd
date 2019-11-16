extends Node2D
export(PackedScene) var new_barrel
export var respawn_time = 30.0
onready var timer = $Timer
onready var sprite = $Sprite
#onready var barrel = $"MP-14-Barrel"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	timer.wait_time = respawn_time
	sprite.visible = false
#	_spawn_new_barrel()
#	barrel.connect("boom",self,"start_timer")
#	print("clearing barrel")
#	barrel.queue_free()
#	print("spawning new barrel?")
#	_spawn_new_barrel()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _spawn_new_barrel():
#	print("yes i am", self.global_position)
	var nb = new_barrel.instance()
	Map_Hand.add_kid_to_map(nb)
	nb.init(-1, self.global_transform)
#	nb.global_position = self.global_position
#	print("new_barrel", nb.position)
	nb.connect("boom",self,"start_timer")
#	#	barrel = nb

func start_timer():
#	print("timer start")
	timer.start()

func _on_Timer_timeout():
#	print("time out")
	_spawn_new_barrel()
