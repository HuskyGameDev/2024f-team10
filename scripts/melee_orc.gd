extends Unit

@onready var attack_timer: Timer = $AttackTimer
@onready var regen_timer: Timer = $RegenTimer
@onready var range: CollisionShape3D = $DetectionRange/Range

@onready var path1 = $"../Path1".get_curve()
@onready var path1Array = path1.get_baked_points()

@onready var path2 = $"../Path2".get_curve()
@onready var path2Array = path2.get_baked_points()

@onready var path3 = $"../Path3".get_curve()
@onready var path3Array = path3.get_baked_points()

var currentPath = 0

var currentPathPOS = 0

@export var speed: int = 2

@export var Path : PathFollow3D

var canAttack : bool
var isAttacking 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHealth = MAX_HEALTH
	# setup the attack range:
	var rangeDetector = SphereShape3D.new()
	rangeDetector.radius = attackRange
	
	attack_timer.wait_time = attackSpeed
	
	range.shape = rangeDetector

func _process(delta: float) -> void:
	# if health is zero, the unit dies
	if (currentHealth <= 0):
		queue_free()
	
	if(canAttack && cur_tar != null):
		attack(cur_tar)
		attack_timer.start()
		canAttack = false

func _physics_process(delta):
	#Path.progress += speed * delta
	#global_position = Path.global_position
	#Path.set_progress(Path.get_progress() * speed * delta)
	
	#if Path.get_progress_ratio() >= 0.99:
	#	Path.queue_free()
	#	queue_free()
	print(currentPath)
	if ((cur_tar == null) && (path1Array.size() > currentPathPOS) && (currentPath == 1)):
		var PATHPOS = path1Array[currentPathPOS]
		currentPathPOS += 1
		#print(currentPath)
		#print(PATHPOS)
		global_position = PATHPOS
		pass
		
	if ((cur_tar == null) && (path1Array.size() > currentPathPOS) && (currentPath == 2)):
		var PATHPOS = path2Array[currentPathPOS]
		currentPathPOS += 1
		print("PATH 2222222222222222")
		#print(PATHPOS)
		global_position = PATHPOS
		pass
		
	if ((cur_tar == null) && (path1Array.size() > currentPathPOS) && (currentPath == 3)):
		var PATHPOS = path3Array[currentPathPOS]
		currentPathPOS += 1
		#print(currentPath)
		#print(PATHPOS)
		global_position = PATHPOS
		pass
		
	if (((currentPath == 1) && (path1Array.size() == currentPathPOS)) || ((currentPath == 2) && (path2Array.size() == currentPathPOS)) ||((currentPath == 3) && (path3Array.size() == currentPathPOS))):
		queue_free()
		pass
	


func attack(target : StaticBody3D):
	if (target.is_in_group("Tower Troop") || target.is_in_group("Tower")):
		target.take_damage(attackDmg)

func damage(amount : float):
	currentHealth -= amount
	$HealthBar3D.update(currentHealth, MAX_HEALTH)

# called every 0.1 seconds
func _on_regen_timer_timeout() -> void:
	if currentHealth < MAX_HEALTH:
		currentHealth = clamp(currentHealth + (healthRegen * regen_timer.wait_time), 0, MAX_HEALTH)
		$HealthBar3D.update(currentHealth, MAX_HEALTH)


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
	if (body.is_in_group("Tower Troop") || body.is_in_group("Tower")):
		targets.append(body)
		choose_target(targets)


func _on_detection_range_body_exited(body: Node3D) -> void:
	if (body.is_in_group("Tower Troop") || body.is_in_group("Tower")):
		targets.erase(body)
		choose_target(targets)

func initialize(start_position, yRotation, path):
	var vec3 = Vector3(0, yRotation, 0)
	
	set_rotation_degrees(vec3)
	print(path)
	currentPath = path
	set_position(start_position)
