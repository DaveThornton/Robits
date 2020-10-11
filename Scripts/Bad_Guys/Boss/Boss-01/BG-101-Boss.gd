extends Node2D
export (PackedScene) var level_to_load

onready var top = $"Tops/BG-101-Boss-Top"
onready var boxes = $Boxes
onready var turrets = $Turrets
onready var tops = $Tops
onready var exit = $Exit
onready var exit_door = $"Exit/MP-15-Level_Change-01-Door"
onready var anim_boom = $Boom_Stuff/AnimationPlayer

var map
var activated = false
var dead_tops = 0
var dead_boxes = 0

func _ready():
	map = Map_Hand.map
	exit_door.level_to_load_1 = level_to_load
#	exit_door.off()
	if !map:
		print("no Map")
	var map_connected = map.connect("activate", self, "activate")
	if !map_connected:
		print("error in BG 101 Boss not connecting to map")

#func _process(delta):
#	pass

func activate(_num, _player):
	if !activated:
		activated = true
		for i in boxes.get_child_count():
			boxes.get_child(i).activate()
			boxes.get_child(i).connect("dead", self, "dead_box")
		for j in tops.get_child_count():
			tops.get_child(j).connect("dead", self, "dead_top")

func dead_box():
#	print("dead box in boss BG 101")
	dead_boxes += 1
	if dead_boxes == boxes.get_child_count():
		top.activate()
		for i in turrets.get_child_count():
			turrets.get_child(i).activate(0,0)
#			turrets.get_child(i).connect("dead", self, "dead_box")
#		print("Activate the turrets !!!! BG 101 Boss")

func dead_top():
	dead()
	dead_tops += 1
	if dead_tops == tops.get_child_count():
		for i in turrets.get_child_count():
			turrets.get_child(i).self_destruct()

func dead():
	anim_boom.play("Boom")
#	print("dead--------------------------------------------------------------------dead")
#	exit.scale = Vector2(1,1)
#	exit.visible = true
#	exit_door.on()
