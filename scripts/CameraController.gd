# Being Worked on by Logan Cole
extends Node3D
@onready var main_camera: Camera3D = $MainCamera

@export var edgeSize : int
@export var movementSpeed : float
@export var movementTime : float
@export var rotationAmount : float
@export var zoomAmount : Vector3

var newPosition : Vector3
var newRotation : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	newPosition = transform.origin
	newRotation = rotation.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleMovementInput(delta)

func handleMovementInput(delta : float) -> void:
	# Check what edges of the screen the mouse is on
	var mousePosition : Vector2 = get_viewport().get_mouse_position()
	var viewportSize : Vector2 = get_viewport().size
	
	var mouseOnLeft : bool = mousePosition.x < edgeSize
	var mouseOnRight : bool = mousePosition.x > viewportSize.x - edgeSize
	var mouseOnTop : bool = mousePosition.y < edgeSize
	var mouseOnBot : bool = mousePosition.y > viewportSize.y - edgeSize
	
	# Get input
	if ( Input.is_key_pressed(KEY_UP) || mouseOnTop):
		newPosition += -transform.basis.z * movementSpeed # -tranform.basis.z is equavalent to transform.fowrard in Unity
	
	if ( Input.is_key_pressed(KEY_DOWN) || mouseOnBot):
		newPosition += transform.basis.z * movementSpeed
	
	if ( Input.is_key_pressed(KEY_LEFT) || mouseOnLeft):
		newPosition += -transform.basis.x * movementSpeed
	
	if ( Input.is_key_pressed(KEY_RIGHT) || mouseOnRight):
		newPosition += transform.basis.x * movementSpeed
	
	if ( Input.is_key_pressed(KEY_Q) ):
		newRotation += rotationAmount
	
	if ( Input.is_key_pressed(KEY_E) ):
		newRotation -= rotationAmount
	

	# Update the position
	transform.origin = lerp( transform.origin, newPosition, delta * movementTime )
	rotation.y = newRotation

func _input(event: InputEvent) -> void:
	if ( event.is_action_pressed("Scroll_Down") ):
		main_camera.transform.origin = clamp( main_camera.transform.origin + zoomAmount, Vector3(0, 10, 10), Vector3(0, 500, 500) )
	if ( event.is_action_pressed("Scroll_Up")):
		main_camera.transform.origin = clamp( main_camera.transform.origin - zoomAmount, Vector3(0, 10, 10), Vector3(0, 500, 500) )
