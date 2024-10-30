extends NinePatchRect

var multival : int = 1

signal multi(value)

#Emits signal to unitBar.gd's _multiplier_change
func _on_pressed(value):
	multival = value
	#print(multival)
	emit_signal("multi", multival)
	pass
