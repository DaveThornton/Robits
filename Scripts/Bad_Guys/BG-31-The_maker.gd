# extends KinematicBody2D
extends Node2D

onready var w1 = $"BG-31-The_Maker-Part"
onready var w2 = $"BG-31-The_Maker-Part2"
onready var w3 = $"BG-31-The_Maker-Part3"
onready var w4 = $"BG-31-The_Maker-Part4"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	is_ready = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(_delta):
	if is_ready:#this is so wrong fix it with bones maybe or scrap the way this goes together and just make it one big sceane
		w1.move(Vector2(-10,10))
		w2.move(Vector2(-10,10))
		w3.move(Vector2(-10,10))
		w4.move(Vector2(-10,10))
		# move_and_slide(Vector2(-100,10))