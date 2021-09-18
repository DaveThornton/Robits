extends RigidBody2D

export(PackedScene) var popped

onready var line = $Line2D
onready var balloon_body = $Balloon_Body
onready var balloon_sprite = $Balloon_Body/CollisionShape2D/Balloon_Sprite
onready var timer = $Timer
var is_popped = false
var my_color
var type = "balloon"

signal death

func _ready():
	if my_color:
		balloon_sprite.self_modulate = my_color

func _process(_delta):
	if !is_popped:
		line.set_point_position(1, Vector2(0,0))
		line.set_point_position(0,Vector2(balloon_body.position))


func on_player(_player):
	pass

func pop():
	if !is_popped:
		is_popped = true
		var x = popped.instance()
		self.get_tree().get_current_scene().add_child(x)
		x.global_position = Vector2(balloon_body.global_position.x, balloon_body.global_position.y - 14)
		emit_signal("death",type)
		balloon_body.call_deferred("free")
		# overweight()
		line_on(false)
		timer.start(0.1)
	else:
		self.queue_free()

func line_on(_on):
	line.visible = _on

func color(_pri, _sec):
	if balloon_sprite:
		balloon_sprite.self_modulate = _pri
	else:
		my_color = _pri

func _on_Timer_timeout():
	pop()
