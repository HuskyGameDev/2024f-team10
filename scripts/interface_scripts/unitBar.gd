extends NinePatchRect

signal emeraldDeduction(value, troopVal, troopNum)

signal spawnTroop(troopVal, troopNum, pathVal)

var multiplier : int = 1

var pathValue : int = 1

var orcCost : int = 1
var meleeCost : int = 2
var rangeCost : int = 3
var heavyCost : int = 4


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

func _path_change(value):
	pathValue = value
	pass

func _on_pressed(value):#Emits sigal to checkEmerald in emerald_counter.gd
	var cost : int = 0
	match value:
		1:
			print("UnitBar: Orc Spawn")
			cost = multiplier*orcCost
			emit_signal("emeraldDeduction", cost, 1, multiplier)
			pass
		2:
			print("UnitBar: Melee Spawn")
			cost = multiplier*meleeCost
			emit_signal("emeraldDeduction", cost, 2, multiplier)
			pass
		3:
			print("UnitBar: Range Spawn")
			cost = multiplier*rangeCost
			emit_signal("emeraldDeduction", cost, 3, multiplier)
			pass
		4:
			print("UnitBar: Heavy Spawn")
			cost = multiplier*heavyCost
			emit_signal("emeraldDeduction", cost, 4, multiplier)
			pass
	
	pass
	#Called by signal enoughEmerald in checkEmerald in emerald_counter.gd
	#Emits signal to game.gd to spawn troops
func costCheck(tfvalue, troopVal, troopNum):
	if tfvalue == true:
		emit_signal("spawnTroop", troopVal, troopNum, pathValue)
		pass
	else:
		pass
