extends VBoxContainer

export(PackedScene) var input_label

func update_stats(_player):
	var pick_up_count = Player_Stats.get_pick_up_count(_player)
	var drop_count = Player_Stats.get_drop_count(_player)
	var throw_count = Player_Stats.get_throw_count(_player)
	var pi_toggle_count = Player_Stats.get_toggle_pi_count(_player)

	var c = self.get_child_count()

	if pick_up_count > 0:
		make_label("pick up ",str(pick_up_count))
	if drop_count > 0:
		make_label("Drops",str(drop_count))
	if throw_count > 0:
		make_label("Throws",str(throw_count))
	if pi_toggle_count > 0:
		make_label("Toggle PI",str(pi_toggle_count))
	if c == self.get_child_count():
		self.visible = false
	else:
		self.visible = true

func make_label(s1,s2):
	var w = input_label.instance()
	self.add_child(w)
	w.update_strings(s1, s2)
