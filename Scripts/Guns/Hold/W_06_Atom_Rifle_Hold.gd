extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

func shoot_j(): _fire()

func call_on_hit_with_no_projectile(_thing): _thing.stun(6)