extends Node2D
export (PackedScene) var level_to_load
export var activation_num = 0

onready var top = $"Tops/BG-101-Boss-Top"
onready var boxes = $Boxes
onready var turrets = $Turrets
onready var tops = $Tops
onready var exit = $Exit
onready var exit_door = $"Exit/MP-15-Level_Change-01-Door"
onready var anim_boom = $Boom_Stuff/AnimationPlayer
onready var turret_01 = $"Turrets/BG-25-Turret-Wall-Back"
onready var turret_02 = $"Turrets/BG-25-Turret-Wall-Back2"

var map
var activated = false
var dead_tops = 0
var dead_boxes = 0

func _ready():
	# if !map:
	# 	print_debug("no Map")
	# match activation_num:
		# 1:Map_Hand.connect("act_01", self, "activate")
	Map_Hand.connect_activate(self, activation_num)

func activate(_body):
	activated = true
	# turret_01.activate(_body)
	# turret_02.activate(_body)
	for i in boxes.get_child_count():
		boxes.get_child(i).activate()
		boxes.get_child(i).connect("dead", self, "dead_box")
	for j in tops.get_child_count():
		tops.get_child(j).connect("dead", self, "dead_top")

func dead_box():
	dead_boxes += 1
	if dead_boxes == boxes.get_child_count():
		top.activate()
		for i in turrets.get_child_count():
			turrets.get_child(i).activate(self)

func dead_top():
	dead()
	dead_tops += 1
	if dead_tops == tops.get_child_count():
		for i in turrets.get_child_count():
			turrets.get_child(i).self_destruct()

func dead():
	anim_boom.play("Boom")
