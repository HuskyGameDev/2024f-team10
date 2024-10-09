extends NinePatchRect

var emeraldCount : int = 0

var passiveEmAdd : int = 1

func passiveEmerald():
	emeraldCount += passiveEmAdd
	var label = get_node("Label")
	label.text = str(emeraldCount)
	pass

func removeEmerald(value):
	emeraldCount -= value
	var label = get_node("Label")
	label.text = str(emeraldCount)
	pass
