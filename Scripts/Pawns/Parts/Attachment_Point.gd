extends RigidBody2D

onready var pin_point = $PinJoint2D
onready var no_attachment = $No_Attachment
var player = 0
var attached_to_pin
var old_pin

func attach(the_thing):
	the_thing.global_position = self.global_position
	self.add_child(the_thing)


func attach_to_pin(the_thing):
	print(the_thing, "   ", self.get_child_count(), "    " )
	var pin = PinJoint2D.new()
	add_child(pin)
	pin.global_position = self.global_position
	
	attached_to_pin = the_thing
	attached_to_pin.global_position = self.global_position
	# attached_to_pin.call_deferred("get_parent().remove_child()",attached_to_pin)
	# attached_to_pin.get_parent().remove_child(attached_to_pin)
	# self.call_deferred("add_child",attached_to_pin)
# 	Map_Hand.call_deferred("add_kid_to_map",attached_to_pin)
# 	self.call_deferred("_attach_to_pin", pin)
# func _attach_to_pin(_pin):
	# pin.global_position = self.global_position
	# attached_to_pin.global_position = self.global_position
	pin.node_a = attached_to_pin.get_path()
	pin.node_b = self.get_path()



# func attach_to_pin(the_thing):
# 	print("trying to attach is it working in attachment point")
# 	if old_pin:
# 		old_pin.queue_free()
# 		Map_Hand.add_kid_to_map(attached_to_pin)
# 	attached_to_pin = the_thing
# 	var pin = PinJoint2D.new()
# 	add_child(pin)
# 	# pin.global_position = self.global_position
# 	# pin.global_position.y -= 1
# 	# the_thing.global_position = self.global_position
# 	# the_thing.global_position.y -= 4
# 	old_pin = pin
# 	call_deferred("_attach_to_pin")
# func _attach_to_pin():
# 	add_child(old_pin)
# 	old_pin.global_position = self.global_position
# 	# pin.global_position.y -= 1
# 	attached_to_pin.global_position = self.global_position
# 	# the_thing.global_position.y -= 4
# 	add_child(attached_to_pin)
# 	old_pin.node_a = attached_to_pin.get_path()
# 	old_pin.node_b = self.get_path()
# 	# print(attached_to_pin.get_path())



# func attach_to_pin(the_thing):
# 	attached_to_pin = the_thing
# 	call_deferred("_attach_to_pin")
# func _attach_to_pin():
# 	print(pin_point.node_a)
# 	print("attachment point says attach to pin how did it go?")
# 	remove()
# 	attached_to_pin.global_position = self.global_position
# 	add_child(attached_to_pin)
# 	pin_point.node_a = attached_to_pin.get_path()
# 	print(pin_point.node_a)

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






