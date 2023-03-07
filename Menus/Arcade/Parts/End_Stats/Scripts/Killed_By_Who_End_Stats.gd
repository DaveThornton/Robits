extends VBoxContainer

export(PackedScene) var player_label

func update_stats(_player):
	clear_old()
	var stats = Player_Stats.get_killed_by_who(_player)
	var c = self.get_child_count()
	for i in stats.size():
		if stats[i] > 0:
			var w = player_label.instance()
			self.add_child(w)
			var s1 = str("player ", i)
			var s2 = str(stats[i])
			w.update_strings(s1, s2)
	if c == self.get_child_count():
		self.visible = false
	else:
		self.visible = true
		
func clear_old():
	for i in self.get_child_count():
		if i > 2:
			self.get_child(i).queue_free()
