extends StaticBody3D

signal death

var health : int = 100
func take_damage(dmg : float):
	health -= dmg
	if health <= 0:
		death.emit()
		queue_free()

func _process(delta):
	pass

func _on_death():
	var emerald_scene = get_tree().get_node("GUI/emeraldCounter")
	emerald_scene.connect("death", self, "resource_tower_destroyed")
