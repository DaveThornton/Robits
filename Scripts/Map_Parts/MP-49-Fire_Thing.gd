extends Node2D

export var how_long = 20
export var time = 0.05
export var time_extended = 2.0

var current_time = 0.0
var going_out = true
var fire = []

func _ready():
	pass

func _process(delta):
	current_time += delta
	if current_time > time:
		current_time = 0.0
		if fire.size() == 0 && going_out:
			var flame = FX.misc.get_flame().instance()
			Map_Hand.add_kid_to_map(flame)
			fire.append(flame)
			flame.global_position = self.global_position
			flame.position.y = flame.position.y + (20 * fire.size())
		elif fire.size() < how_long && going_out:
			if fire.size() > 1:
				fire.back().change_frame(1)
			else:
				fire.front().change_frame(0)
			var flame = FX.misc.get_flame().instance()
			Map_Hand.add_kid_to_map(flame)
			fire.append(flame)
			flame.change_frame(2)
			flame.global_position = self.global_position
			flame.position.y = flame.position.y + (20 * fire.size())
		elif fire.size() == 0 && !going_out:
			going_out = true
			current_time = -time_extended
		elif fire.size() <= how_long && !going_out:
			fire.pop_back().call_deferred("free")
			if fire.size() == 1:
				fire.front().change_frame(3)
			elif fire.size() != 0:
				fire.back().change_frame(2)
		elif fire.size() == how_long && going_out:
			going_out = false
			current_time = -time_extended
		else:
			print("error in map part 49 fire thing",fire.size(), how_long, going_out)
