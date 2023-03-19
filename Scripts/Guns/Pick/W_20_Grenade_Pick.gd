extends 'res://Scripts/Guns/Pick/W_00_Bomb_Pick.gd'


onready var spin_timer = $Timer_Spin
onready var label= $"FX-21-Timer_Label"
export var spin_amount = 2000

func call_end_of_init():
	if ammo == 0:
		label.visible = true
	else:
		label.visible = false
	if player > 0:
		spin(spin_amount)

func _process(_delta):
	if ammo == 0:
		time = timer_boom.time_left
		label.set_time(time)

func spin(_how_much):
	if is_right:
		self.applied_torque = _how_much
	else:
		self.applied_torque = -_how_much
	spin_timer.start()

func _on_Timer_Boom_timeout():
	boom()

func _on_Timer_Hit_timeout():
	dont_hit_player()

func _on_Timer_Spin_timeout():
	self.applied_torque = 0