extends NinePatchRect

var emeraldCount : int = 0

var passiveEmAdd : int = 1 #amount of emeralds added for second

signal enoughEmerald(checkValue, troopN, TroopMulti)
signal resource_tower_destroyed

#Calculates passive Emerald Gain
#Called by timeout() from Timer in emeraldCounter.tscn
func passiveEmerald():
	emeraldCount += passiveEmAdd
	var label = get_node("emeraldLabel")
	label.text = str(emeraldCount)
	pass

#In-Script function. No outside calls
func removeEmerald(value):
	emeraldCount -= value
	var label = get_node("emeraldLabel")
	label.text = str(emeraldCount)
	pass

#called by emeraldDeduction Signal in unitbar which then emits signal
#enoughEmeralds which goes to costCheck in unitBar.gd
func checkEmerald(value, troopNum, troopMultiplier):
	if value <= emeraldCount:
		removeEmerald(value)
		emit_signal("enoughEmerald", true, troopNum, troopMultiplier)
		pass
	else:
		emit_signal("enoughEmerald", false, troopNum, troopMultiplier)
		var label = get_node("notEnoughEmeralds")
		label.text = "Cost to spawn troops: " + str(value) + "\n Current amount of emeralds: " + str(emeraldCount)
		await get_tree().create_timer(1).timeout
		label.text = ""
		pass
		
func addEmerald(value):
	emeraldCount += value
	var label = get_node("emeraldLabel")
	label.text = str(emeraldCount)
	pass


func _on_resource_tower_destroyed():
	addEmerald(20)
