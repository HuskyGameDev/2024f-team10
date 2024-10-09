extends NinePatchRect

var multival : int = 1

signal multi(value)

func _on_pressed(value):
	multival = value
	#print(multival)
	emit_signal("multi", multival)
	pass
