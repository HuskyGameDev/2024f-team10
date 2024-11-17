extends NinePatchRect

var pathVal : int = 1

signal pathOutput(value)

#Emits signal to unitBar.gd's _path_change
func _on_pressed(value):
	pathVal = value
	emit_signal("pathOutput", pathVal)
	pass
