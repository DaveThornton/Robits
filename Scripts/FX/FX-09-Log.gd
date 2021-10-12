extends RigidBody2D

export var frame = 1

onready var log_sprite = $Sprite
onready var tree_sprite = $Ever_Tree_00
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if frame == 0:
		log_sprite.visible = false
		tree_sprite.visible = true
	else:
		log_sprite.visible = true
		tree_sprite.visible = false		
		log_sprite.frame = frame - 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
