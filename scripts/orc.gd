extends Unit

@onready var attack_timer: Timer = $AttackTimer
@onready var regen_timer: Timer = $RegenTimer

var canAttack : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHealth = MAX_HEALTH
	
	# setup the attack range:
	var rangeDetector = SphereShape3D.new()
	rangeDetector.radius = attackRange
	
	attack_timer.wait_time = attackSpeed
	

func _process(delta: float) -> void:
	apply_force(-transform.basis.z * 14 * delta)
	# if health is zero, the unit dies
	if (currentHealth <= 0):
		queue_free()
	
	if(canAttack && cur_tar != null):
		look_at(cur_tar.position)
		attack(cur_tar)
		attack_timer.start()
		canAttack = false




func attack(target : StaticBody3D):
	if (target.is_in_group("Tower Troop")):
		target.take_damage(attackDmg)
		print(target.to_string() + " attacked")
func damage(amount : float):
	currentHealth -= amount

# called every 0.1 seconds
func _on_regen_timer_timeout() -> void:
	if currentHealth < MAX_HEALTH:
		currentHealth = clamp(currentHealth + (healthRegen * regen_timer.wait_time), 0, MAX_HEALTH)
		print(currentHealth)


func _on_attack_timer_timeout() -> void:
	canAttack = true

# enemy detection code
var targets : Array = []
var cur_tar : StaticBody3D
var can_shoot : bool = true

func choose_target(targets : Array) -> void:
	var temp_array : Array = targets
	var current_target : StaticBody3D = null
	for i in temp_array:
		if current_target == null:
			current_target = i
	cur_tar = current_target


func _on_detection_range_body_entered(body: Node3D) -> void:
	if body.is_in_group("Tower Troop"):
		targets.append(body)
		choose_target(targets)


func _on_detection_range_body_exited(body: Node3D) -> void:
	if body.is_in_group("Tower Troop"):
		targets.erase(body)
		choose_target(targets)

func initialize(start_position, yRotation):
	var vec3 = Vector3(0, yRotation, 0)
	set_rotation_degrees(vec3)
	print(str(get_rotation()))
	set_position(start_position)
