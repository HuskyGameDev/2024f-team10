extends CharacterBody3D

var target : StaticBody3D
var speed : int = 120
var damage : int = 5

func _physics_process(delta):
	if is_instance_valid(target):
		velocity = global_position.direction_to(target.global_position) * speed * delta
		look_at(target.global_position)
		move_and_slide()
	else:
		queue_free()

func _on_collision_body_entered(body):
	if (body.is_in_group("Tower") || body.is_in_group("Tower Troop")):
		body.take_damage(damage)
		queue_free()
