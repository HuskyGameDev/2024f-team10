extends StaticBody3D

signal death(value)

var emeraldDrop = 20

var health : int = 100
func take_damage(dmg : float):
	health -= dmg
	$HealthBar3D.update(health, 100)
	if health <= 0:
		death.emit()
		queue_free()

func _process(delta):
	pass

func _on_death():	
	emit_signal("death", emeraldDrop)
	pass
