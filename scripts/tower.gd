extends StaticBody3D

var bullet
var damage : int = 5
var targets : Array = []
var cur_tar : CharacterBody3D
var can_shoot : bool = true

func choose_target(targets : Array) -> void:
	var temp_array : Array = targets
	var current_target : CharacterBody3D = null
	for i in temp_array:
		if current_target == null:
			current_target = i
	cur_tar = current_target

func _on_detection_range_body_entered(body):
	if body.is_in_group("Enemy"):
		targets.append(body)
		choose_target(targets)

func _on_detection_range_body_exited(body):
	if body.is_in_group("Enemy"):
		targets.erase(body)
		choose_target(targets)
