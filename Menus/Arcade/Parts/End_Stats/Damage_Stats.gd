extends VBoxContainer

export(PackedScene) var damage_label

func update_stats(_player):
	var dmg_given = Player_Stats.get_dmg_given(_player)
	var dmg_taken = Player_Stats.get_dmg_taken(_player)

	var c = self.get_child_count()

	if dmg_given > 0:
		make_label("Given",str(dmg_given))
	if dmg_taken > 0:
		make_label("Taken",str(dmg_taken))
	if c == self.get_child_count():
		self.visible = false
	else:
		self.visible = true

func make_label(s1,s2):
	var w = damage_label.instance()
	self.add_child(w)
	w.update_strings(s1, s2)
