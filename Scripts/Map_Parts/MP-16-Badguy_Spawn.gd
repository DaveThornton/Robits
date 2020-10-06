extends Area2D

export(PackedScene) var badguy

export var only_once = true

onready var sprite = $Sprite

var spawn = true


func _ready():
	sprite.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func triggered():
	if spawn:
		if only_once:
			spawn = false
		var new_bg = badguy.instance()
		Map_Hand.add_bg_to_map(new_bg)
		new_bg.global_position = self.global_position
#	print("Triggered by camera to spawn a bad guy")
