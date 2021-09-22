extends RigidBody2D

onready var pin_point = $PinJoint2D
onready var no_attachment = $No_Attachment
onready var attach_pic = $Attach

var player = 0
var attached_to_pin
var old_pin

func attach(the_thing):
	the_thing.global_position = self.global_position
	self.add_child(the_thing)

# func _process(_delta):
# 	self.global_rotation = 0.0

func attach_to_pin(the_thing):
	print(the_thing, "   ", self.get_child_count(), "    in attachment point" )
	var pin = PinJoint2D.new()
	self.add_child(pin)
	self.add_child(the_thing)
	pin.global_position = self.global_position
	attached_to_pin = the_thing
	attached_to_pin.global_position = self.global_position
	pin.node_a = attached_to_pin.get_path()
	pin.node_b = self.get_path()

func remove():
	if attached_to_pin != no_attachment:
		self.remove_child(get_node(pin_point.node_a))
		Map_Hand.add_kid_to_map(get_node(pin_point.node_a))
		attached_to_pin = no_attachment
	pin_point.node_a = no_attachment.get_path()

func set_player(_num):
	player = _num

func get_player():
	return player
