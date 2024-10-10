extends CharacterBody3D

var target : Unit
var speed : int = 20
var damage : int

func _physics_process(delta):
	if is_instance_valid(target):
		velocity = global_position.direction_to(target.global_position) * speed
		move_and_slide()
	else:
		queue_free()

func _on_collision_body_entered(body):
	if body.is_in_group("Orc Troop"):
		body.damage(damage)
		queue_free()
