extends NinePatchRect

var emeraldCount : int = 0

var passiveEmAdd : int = 1 #amount of emeralds added for second

signal enoughEmerald(checkValue, troopN, TroopMulti)

func passiveEmerald():
	emeraldCount += passiveEmAdd
	var label = get_node("emeraldLabel")
	label.text = str(emeraldCount)
	pass

func removeEmerald(value):
	emeraldCount -= value
	var label = get_node("emeraldLabel")
	label.text = str(emeraldCount)
	pass

func checkEmerald(value, troopNum, troopMultiplier):#called by emeraldDeduction Signal in unitbar
	if value <= emeraldCount:
		removeEmerald(value)
		emit_signal("enoughEmerald", true, troopNum, troopMultiplier)
		pass
	else:
		emit_signal("enoughEmerald", false, troopNum, troopMultiplier)
		pass
