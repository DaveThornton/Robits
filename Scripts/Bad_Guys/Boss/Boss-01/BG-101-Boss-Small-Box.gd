extends Node2D

export(PackedScene) var projectile
export(PackedScene) var explode
export var light_color = Color8(255, 255, 255, 255)
export var hit_color = Color8(255, 255, 255, 255)
export var speed = 6500
export var damage = 20
export var health = 150
export var armor = 3
export var can_shoot = false

onready var light = $"BG-101-Boss-Small-Box-Light"

var hit_time = 0.0

func _ready():
	light.self_modulate = light_color

func _process(delta):
	if hit_time > 0.0:
		hit_time -= delta
		light.self_modulate = hit_color
	else:
		light.self_modulate = light_color

func hit(_by_who, _by_what, _damage_type, _damage):
	hit_time += .1
	health -= (_damage - armor)
	if health <= 0:
		print("small box in bg 101 boss killed")
		call_deferred("_explode")
		call_deferred("free")
		
func _explode():
	var e = explode.instance()
	Map_Hand.add_kid_to_map(e)
	e.init(9, self.position, str("player ", e, "'s destruct system"), 0, 0)
