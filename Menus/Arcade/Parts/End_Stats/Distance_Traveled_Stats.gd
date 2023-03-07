extends VBoxContainer

export(PackedScene) var dis_label

func update_stats(_player):
	clear_old()
	var dis_on_land = Player_Stats.get_ground_distance(_player)
	var dis_in_air = Player_Stats.get_air_distance(_player)
	var dis_jump_up = Player_Stats.get_jump_up_distance(_player)
	var dis_drop_dn = Player_Stats.get_drop_dn_distance(_player)
	var num_l_jump = Player_Stats.get_jump_count(_player)
	var num_a_jump = Player_Stats.get_air_jump_count(_player)
	var num_plats_jump = Player_Stats.get_jump_down_count(_player)

	var c = self.get_child_count()

	if dis_on_land > 0:
		make_label("On Land",str(dis_on_land))
	if dis_in_air > 0:
		make_label("In Air",str(dis_in_air))
	if dis_jump_up > 0:
		make_label("going up",str(dis_jump_up))
	if dis_drop_dn > 0:
		make_label("Dropped",str(dis_drop_dn))
	if num_l_jump > 0:
		make_label("land jumps",str(num_l_jump))
	if num_a_jump > 0:
		make_label("Air Jumps",str(num_a_jump))
	if num_plats_jump > 0:
		make_label("Jump Down",str(num_plats_jump))
	if c == self.get_child_count():
		self.visible = false
	else:
		self.visible = true

func make_label(s1,s2):
	var w = dis_label.instance()
	self.add_child(w)
	w.update_strings(s1, s2)

func clear_old():
	for i in self.get_child_count():
		if i > 2:
			self.get_child(i).queue_free()
