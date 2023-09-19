extends Area2D

# export(PackedScene) var badguy
export var bad_guy_number = 3
export var only_once = true
export var spawn_at_start = false
onready var sprite = $Sprite

var spawn = true

func _ready():
	sprite.visible = false
	if spawn_at_start:
		triggered()

func set_spawn_at_start(_set:bool):
	spawn_at_start = _set
	if spawn:
		triggered()

func set_bad_guy(_num):
	bad_guy_number = _num

func triggered():
	if spawn:
		if only_once:
			spawn = false
		var new_bg = Campaign.get_bad_guy(bad_guy_number).instance()
		# var new_bg = badguy.instance()
		Map_Hand.add_bg_to_map(new_bg)
		new_bg.global_position = self.global_position
#	print_debug("Triggered by camera to spawn a bad guy")
