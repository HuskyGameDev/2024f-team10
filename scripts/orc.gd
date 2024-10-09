extends Unit

@onready var shape_cast_3d: ShapeCast3D = $ShapeCast3D
@onready var attack_timer: Timer = $AttackTimer
@onready var regen_timer: Timer = $RegenTimer

var canAttack : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHealth = MAX_HEALTH
	
	# setup the attack range:
	var rangeDetector = SphereShape3D.new()
	rangeDetector.radius = attackRange
	shape_cast_3d.shape = rangeDetector
	
	attack_timer.wait_time = 1 / attackSpeed
	

func _process(delta: float) -> void:
	# if health is zero, the unit dies
	if (currentHealth <= 0):
		queue_free()
	
	if(canAttack):
		damage(attackDmg)
		attack_timer.start()
		canAttack = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func damage(amount : int):
	currentHealth -= amount

# called every 0.1 seconds
func _on_regen_timer_timeout() -> void:
	if currentHealth < MAX_HEALTH:
		currentHealth = clamp(currentHealth + (healthRegen * regen_timer.wait_time), 0, MAX_HEALTH)
		print(currentHealth)


func _on_attack_timer_timeout() -> void:
	canAttack = true
