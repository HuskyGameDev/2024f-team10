extends StaticBody3D

var health : int = 100
func take_damage(dmg : float):
	health -= dmg
	if health <= 0:
		#add emeralds
		queue_free()

func _process(delta):
	pass
