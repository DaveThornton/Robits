extends Node2D

export var c_01_time = 1.1
export var c_02_time = 1.2
export var c_03_time = 1.1
export var c_04_time = 1.2
export var activation_num = 0

onready var anim = $AnimationPlayer
onready var hit_spot  = $Parts/BG_104_Hit_Spot
onready var cannon_01 = $Parts/BG_104_Boss_Cannon_01
onready var cannon_02 = $Parts/BG_104_Boss_Cannon_02
onready var cannon_03 = $Parts/BG_104_Boss_Cannon_03
onready var cannon_04 = $Parts/BG_104_Boss_Cannon_04
onready var bg_spawn = $"MP-52-BG-3-Spawner"

var map
var activated = false
var is_dead = false

func _ready():
	map = Map_Hand.map
	if !map:
		print_debug("no Map")
	var map_connected = map.connect("activate", self, "activate")
	if !map_connected:
		print_debug("error in BG 104 Boss not connecting to map")
	hit_spot.connect("dead_hit_spot", self , "dead")
	cannon_01.start(c_01_time)
	cannon_02.start(c_02_time)
	cannon_03.start(c_03_time)
	cannon_04.start(c_04_time)
	bg_spawn.set_activation_num(activation_num)
	cannon_01.set_can_shoot(false)
	cannon_02.set_can_shoot(false)
	cannon_03.set_can_shoot(false)
	cannon_04.set_can_shoot(false)
	bg_spawn.set_can_spawn(false)

func activate(_num, _player):
	if !activated && activation_num == _num && !is_dead:
		activated = true
		cannon_01.set_can_shoot(true)
		cannon_02.set_can_shoot(true)
		cannon_03.set_can_shoot(true)
		cannon_04.set_can_shoot(true)
		bg_spawn.set_can_spawn(true)
		

func dead(): 
	is_dead = true
	anim.play("Hit")
	cannon_01.set_can_shoot(false)
	cannon_02.set_can_shoot(false)
	cannon_03.set_can_shoot(false)
	cannon_04.set_can_shoot(false)
	bg_spawn.set_can_spawn(false)
	print_debug("boss 104 im dead now")



















