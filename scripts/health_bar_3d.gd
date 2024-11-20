extends Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	texture = $SubViewportContainer/SubViewport.get_texture()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


@onready var bar = $SubViewportContainer/SubViewport/HealthBar2D
func update(value, full):
	bar.update_bar(value, full)
	pass
