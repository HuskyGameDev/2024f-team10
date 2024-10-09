# Being Worked on by Logan Cole
class_name Unit
extends CharacterBody3D



# Unit stats
@export_category("Unit Stats")
@export var MAX_HEALTH : float
@export var currentHealth : float
@export var healthRegen : float
@export var attackDmg : float
@export var attackSpeed : float
@export var attackRange : float


# custom fucntions
func attack(target : Unit):
	pass

func damage(amount : float):
	pass
