extends Node2D

onready var anim = $AnimationPlayer
onready var hit_plate = $Top/Hit_Plate
onready var cannon_01 = $"Back/BG-105-Cannon_01"
onready var cannon_02 = $"Top/BG-105-Cannon_02"
onready var door_1 = $"Back/MP-52-BG-3-Spawner"
onready var door_2 = $"Back/MP-52-BG-3-Spawner2"
onready var tur_01 = $"Top/BG-25-Turret-Wall-Back"

var shoot_cannon_every = 1
var spawn_at_door_every = 5

var c1_shoot_time = .5
var c2_shoot_time = 0
var d1_spawn_time = 2.5
var d2_spawn_time = 0

func _ready():
	hit_plate.connect("dead",self,"dead")

func _process(delta):
	c1_shoot_time += delta
	c2_shoot_time += delta
	d1_spawn_time += delta
	d2_spawn_time += delta
	if c1_shoot_time >= shoot_cannon_every: 
		cannon_01.shoot()
		c1_shoot_time = 0
	if c2_shoot_time >= shoot_cannon_every: 
		cannon_02.shoot()
		c2_shoot_time = 0
	if d1_spawn_time >= spawn_at_door_every: 
		door_1.spawn()
		d1_spawn_time = 0
	if d2_spawn_time >= spawn_at_door_every: 
		door_2.spawn()
		d2_spawn_time = 0

func dead():
	anim.play("Dead")
	door_1.hit(-1, 104, "laser", 5000)
	door_2.hit(-1, 104, "laser", 5000)
	cannon_01.hit(-1, 104, "laser", 5000)
	cannon_02.hit(-1, 104, "laser", 5000)

func _on_Timer_timeout():
	tur_01.activate(tur_01)