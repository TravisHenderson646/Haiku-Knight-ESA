extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

@export var JUMP_VELOCITY = -150.0
# todo change the project settings gravity to be!!!!!!!!!!!!!!!!!!!!!!!!!! synced with RigidBody nodes.
@export var GRAVITY = 350.0
@export var ACCELERATION = 200.0
@export var FRICTION = 200.0

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_movement(delta)
	move_and_slide()

func _process(delta):
	pass # put animations in here

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released('jump') and velocity.y <= 0:
		velocity.y = velocity.y / 3.0

@export var MAX_SPEED = 100.0
func handle_movement(delta):
	var input_x_direction = int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left'))
	var frame_acceleration = 0.0
	if input_x_direction:
		frame_acceleration = ACCELERATION * delta
		velocity.x = move_toward(velocity.x, input_x_direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, FRICTION * delta)
		
