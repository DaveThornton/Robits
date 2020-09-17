extends Node2D

onready var box1 = $"Boxes/BG-101-Boss-Small-Box"
onready var box2 = $"Boxes/BG-101-Boss-Small-Box2"
onready var box3 = $"Boxes/BG-101-Boss-Small-Box3"
onready var box4 = $"Boxes/BG-101-Boss-Small-Box4"
onready var box5 = $"Boxes/BG-101-Boss-Small-Box5"
onready var box6 = $"Boxes/BG-101-Boss-Small-Box6"

var map
#var map_connected

func _ready():
	map = Map_Hand.map
	if !map:
		print("no Map")
	var map_connected = map.connect("activate", self, "activate")
	if !map_connected:
		print("error in BG 101 Boss not connecting to map")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if !map_connected:
#		map_connected = map.connect("activate", self, "activate")
#		if !map_connected:
#			print("error in BG 101 Boss not connecting to map")

func activate(_num, _player):
	box1.activate()
	box2.activate()
	box3.activate()
	box4.activate()	
	box5.activate()
	box6.activate()
	print("Activate!!!! BG 101 Boss")
