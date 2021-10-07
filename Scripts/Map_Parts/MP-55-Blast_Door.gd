extends StaticBody2D
export(PackedScene) var explosion
export var health = 100
onready var anim = $AnimationPlayer
var player = -1

func _ready():
	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= _damage
	if health <= 0:
		anim.play("Dead") 
	else:
		anim.queue("Hit")

func explode():
	call_deferred("_explode")

func _explode():
	var e = explosion.instance()
	Map_Hand.add_kid_to_map(e)
#	get_tree().get_current_scene().map.add_child(x)
	e.init(9, self.position, str("Blast Door Destruct System"), 0, 0)

























