extends Node2D

onready var timer = $Timer
onready var sprite = $Sprite
export(PackedScene) var trash_part

export var rand_trash = true
export var spawn_time = 1.0
export var shoot_dir = Vector2(0,0)
export var trash_time = 30.0
export var trash_num = 3

var rng = RandomNumberGenerator.new()

func _ready():
	sprite.visible = false
	timer.wait_time = spawn_time
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	var part = trash_part.instance()
	Map_Hand.add_kid_to_map(part)
	if rand_trash:
		trash_num = rng.randi_range(0, 20)
#		print_debug(trash_num)
	part.init(trash_num, self.global_position, shoot_dir, trash_time)
#	part.init(1, 1, 1, true, (self.global_position + Vector2(-7, -7)), shoot_dir)# its for the robit wreckage
