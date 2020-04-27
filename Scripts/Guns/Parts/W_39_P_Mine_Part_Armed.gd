extends Node2D

export(PackedScene) var boom
export var time_out = 15.0
onready var ex_spot = $Position2D
onready var timer_out = $Timer_Out
onready var anim = $AnimationPlayer

var player = 0
var my_name = "Prox Mine"
var armed = false
var damage = 0

func _ready():
	anim.play("Flash")
#	pass # Replace with function body.

func init(_player, _dmg, _pos, _rot):
	player = _player 
	damage = _dmg
	self.position = _pos
	self.rotation_degrees = _rot

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func destruct():
	call_deferred("_destruct")
func _destruct():
	var b = boom.instance()
	Map_Hand.add_kid_to_map(b)
	b.init(player, ex_spot.global_position, my_name, 0, damage)
	queue_free()

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if armed:
			destruct()
#		var b = boom.instance()
#		Map_Hand.add_kid_to_map(b)
#		b.init(player, ex_spot.global_position, my_name, 0, damage)
#		queue_free()

func _on_Timer_In_timeout():
	armed = true
	timer_out.start(time_out)

func _on_Timer_Out_timeout():
	destruct()
