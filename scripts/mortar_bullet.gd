extends CharacterBody3D

var target : Unit
var speed : int = 5
var damage : int = 15
var splashDamage : int = 7
var splashTargets : Array = []

func _physics_process(delta):
	if is_instance_valid(target):
		velocity = global_position.direction_to(target.global_position) * speed
		look_at(target.global_position)
		move_and_slide()
	else:
		queue_free()

func _on_collision_body_entered(body):
	for i in splashTargets:
		i.damage(splashDamage)
	if body.is_in_group("Orc Troop"):
		body.damage(damage)
		queue_free()


func _on_splash_damage_body_entered(body):
	if body.is_in_group("Orc Troop"):
		splashTargets.append(body)
