extends CharacterBody2D

# constant for 2D tile size (16x16) 
const PIXELS = 16

@export_category("Movement Parameters")
@export var jump_peak_time: float = 0.25
@export var jump_fall_time: float = 0.25
@export var jump_height: float = 3.0 * PIXELS
@export var jump_distance: float = 4.0 * PIXELS
@export var coyote_time: float = 0.1

@onready var coyote_timer = $Coyote_Timer

var jump_velocity: float
var jump_gravity: float
var fall_gravity: float
var speed: float
var jump_available: bool = true

func _ready() -> void:
	calculate_movement_parameters()

func calculate_movement_parameters() -> void:
	jump_gravity = (2 * jump_height) / pow(jump_peak_time, 2)
	fall_gravity = (2 * jump_height) / pow(jump_fall_time, 2)
	jump_velocity = jump_gravity * jump_peak_time
	speed = jump_distance / (jump_peak_time + jump_fall_time)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start(coyote_time)
	
		if velocity.y > 0:
			velocity.y += jump_gravity * delta
		else:
			velocity.y += fall_gravity * delta
	else:
		jump_available = true
		coyote_timer.stop()
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_available:
		velocity.y -= jump_velocity
		jump_available = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
func _on_coyote_timer_timeout():
	jump_available = false
