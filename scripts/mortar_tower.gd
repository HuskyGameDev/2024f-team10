extends StaticBody3D

var bullet
var damage : int = 5
var targets : Array = []
var cur_tar : Unit
var can_shoot : bool = true

func choose_target(targets : Array) -> void:
	var temp_array : Array = targets
	var current_target : Unit = null
	for i in temp_array:
		if current_target == null:
			current_target = i
	cur_tar = current_target

func _on_detection_range_body_entered(body):
	if body.is_in_group("Orc Troop"):
		targets.append(body)
		choose_target(targets)

func _on_detection_range_body_exited(body):
	if body.is_in_group("Orc Troop"):
		targets.erase(body)
		choose_target(targets)

func _on_too_close_range_body_entered(body: Node3D) -> void:
	if body.is_in_group("Orc Troop"):
		targets.erase(body)
		choose_target(targets)
