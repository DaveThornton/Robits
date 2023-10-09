extends RigidBody2D

export var frame = 1

onready var log_sprite = $Sprite
onready var tree_sprite = $Ever_Tree_00

func _ready():
	if frame == 0:
		log_sprite.visible = false
		tree_sprite.visible = true
	else:
		log_sprite.visible = true
		tree_sprite.visible = false		
		log_sprite.frame = frame - 1

func warp_to(_pos): self.global_position = _pos