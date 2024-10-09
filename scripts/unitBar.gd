extends NinePatchRect

signal emeraldDeduction(value)

var multiplier : int = 1

var orcCost : int = 1
var meleeCost : int = 2
var rangeCost : int = 3
var heavyCost : int = 4

#Sill need to implement check for emerald value might make emeraldCount a global variable so there isn't 20 signals

func _multiplier_change(value):
	multiplier = value
	
	var orcLabel = get_node("OrcLabel")
	var meleeLabel = get_node("MeleeLabel")
	var rangeLabel = get_node("RangeLabel")
	var heavyLabel = get_node("HeavyLabel")
	
	orcLabel.text =  str("Cost: ", multiplier*orcCost)
	meleeLabel.text = str("Cost: ", multiplier*meleeCost)
	rangeLabel.text = str("Cost: ", multiplier*rangeCost)
	heavyLabel.text = str("Cost: ", multiplier*heavyCost)
	pass

func _on_pressed(value):
	var cost : int = 0
	match value:
		1:
			print("Orc Spawn")
			cost = multiplier*orcCost
		2:
			print("Melee Spawn")
			cost = multiplier*meleeCost
		3:
			print("Range Spawn")
			cost = multiplier*rangeCost
		4:
			print("Heavy Spawn")
			cost = multiplier*heavyCost
	
	emit_signal("emeraldDeduction", cost)
	pass
