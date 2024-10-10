extends StaticBody3D

var bullet : PackedScene = preload("res://scenes/bullet.tscn")
var health : int = 100
var damage : int = 5
var targets : Array = []
var cur_tar : Unit
var can_shoot : bool = true

func shoot() -> void:
	var temp_bullet : CharacterBody3D = bullet.instantiate()
	temp_bullet.target = cur_tar
	temp_bullet.damage = damage
	get_node("BulletContainer").add_child(temp_bullet)
	temp_bullet.global_position = $Tower2/Aim.global_position

func take_damage(dmg : float):
	health -= dmg
	if health <= 0:
		queue_free()

func _process(delta):
	if health <= 0:
		queue_free()
	if is_instance_valid(cur_tar):
		look_at(cur_tar.global_position)
		if can_shoot:
			shoot()
			can_shoot = false
			$FireRate.start()
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()

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

func _on_fire_rate_timeout() -> void:
	can_shoot = true
