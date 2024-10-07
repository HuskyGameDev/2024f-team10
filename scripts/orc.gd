extends Unit

@onready var shape_cast_3d: ShapeCast3D = $ShapeCast3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHealth = MAX_HEALTH
	
	# setup the attack range:
	var rangeDetector = SphereShape3D.new()
	rangeDetector.radius = attackRange
	shape_cast_3d.shape = rangeDetector
	
	# Initialize the regenTimer
	regenTimer = $Timer

func _process(delta: float) -> void:
	# if health is zero, the unit dies
	if (currentHealth <= 0):
		queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func attack(target : Unit):
	target.currentHealth -= attackDmg

# called every 0.1 seconds
func _on_timer_timeout() -> void:
	if currentHealth < MAX_HEALTH:
		currentHealth = clamp(currentHealth + (healthRegen * regenTimer.wait_time), 0, MAX_HEALTH)
		print("Healing")
	
