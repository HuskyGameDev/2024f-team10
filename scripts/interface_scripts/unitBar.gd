extends NinePatchRect

signal emeraldDeduction(value, troopVal, troopNum)

signal spawnTroop(troopVal, troopNum)

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
			emit_signal("emeraldDeduction", cost, 1, multiplier)
			pass
		2:
			print("Melee Spawn")
			cost = multiplier*meleeCost
			emit_signal("emeraldDeduction", cost, 2, multiplier)
			pass
		3:
			print("Range Spawn")
			cost = multiplier*rangeCost
			emit_signal("emeraldDeduction", cost, 3, multiplier)
			pass
		4:
			print("Heavy Spawn")
			cost = multiplier*heavyCost
			emit_signal("emeraldDeduction", cost, 4, multiplier)
			pass
	
	pass
	
func costCheck(tfvalue, troopVal, troopNum):#Called by signal enoughEmerald in emerald_counter.gd
	if tfvalue == true:
		emit_signal("spawnTroop", troopVal, troopNum)
		pass
	else:
		pass
