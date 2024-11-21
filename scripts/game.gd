extends Node3D

@export var Orc: PackedScene
@export var meleeOrc: PackedScene
@export var rangeOrc: PackedScene
@export var tankOrc: PackedScene



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Triggered by signal from unitBar.gd
func _on_mob_spawn(troopId, spawnCount, pathVal):

	for i in range(spawnCount):
		# Get a random point along the path for each mo
		#print(pathVal)
		mob_spawn(troopId, pathVal)
		await get_tree().create_timer(.1).timeout
		
func mob_spawn(troopId, path):
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	
	mob_spawn_location.progress_ratio = randf()
	var spawn_position = mob_spawn_location.position

	
	#var towers = get_tree().get_nodes_in_group("test_level_towers")
	#print(towers)
	#print(towers[1].position)
	#towers.sort()
	
	match troopId:
		1:
			print("Orc Spawn: " + str(spawn_position))
			var orc = Orc.instantiate()
			# Set a unique position for each mob by randomizing the progress ratio
			
			# Initialize mob with its unique spawn position
			orc.initialize(spawn_position, 0, path)
			# Add mob to the scene
			print("Orc Position" + str(orc.position))
			add_child(orc)
			pass
			
		2:#meleeOrc
			print("Melee Spawn")
			print("Orc Spawn: " + str(spawn_position))
			var orc = meleeOrc.instantiate()
			# Set a unique position for each mob by randomizing the progress ratio
			
			# Initialize mob with its unique spawn position
			orc.initialize(spawn_position, 0, path)
			# Add mob to the scene
			print("Orc Position" + str(orc.position))
			add_child(orc)
			pass
			
		3:#rangeOrc
			print("Range Spawn")
			print("Orc Spawn: " + str(spawn_position))
			var orc = rangeOrc.instantiate()
			# Set a unique position for each mob by randomizing the progress ratio
			
			# Initialize mob with its unique spawn position
			orc.initialize(spawn_position, 0, path)
			# Add mob to the scene
			print("Orc Position" + str(orc.position))
			add_child(orc)
			pass
			
		4:#tankOrc
			print("Heavy Spawn")
			print("Orc Spawn: " + str(spawn_position))
			var orc = tankOrc.instantiate()
			# Set a unique position for each mob by randomizing the progress ratio
			
			# Initialize mob with its unique spawn position
			orc.initialize(spawn_position, 0, path)
			# Add mob to the scene
			print("Orc Position" + str(orc.position))
			add_child(orc)
			pass
