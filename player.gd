extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sword = $Sword
@onready var animation_player = $Sword/AnimationPlayer

@export var JUMP_IMPULSE = -165.0
# todo change the project settings gravity to be!!!!!!!!!!!!!!!!!!!!!!!!!! synced with RigidBody nodes.
@export var GRAVITY = 350.0
@export var ACCELERATION = 200.0
@export var FRICTION = 200.0
@export var MAX_SPEED = 100.0
var input_x_direction = 0
var x_knockback = 0
var y_knockback_impulse = -130

func _physics_process(delta):
	input_x_direction = int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left'))
	apply_gravity(delta)
	handle_jump()
	handle_movement(delta)
	if Input.is_action_just_pressed('attack'):
		print('attack')
		animation_player.play('Attack')
	move_and_slide()

func _process(delta):	
	if input_x_direction == 1:
		animated_sprite_2d.play('run')
		animated_sprite_2d.flip_h = false
	elif input_x_direction == -1:
		animated_sprite_2d.play('run')
		animated_sprite_2d.flip_h = true
	elif is_on_floor():
		animated_sprite_2d.play('idle')
	if not is_on_floor():
		if velocity.y >= 0:
			animated_sprite_2d.play('fall')
		if velocity.y < 0:
			animated_sprite_2d.play('jump')

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_IMPULSE
	if Input.is_action_just_released('jump') and velocity.y <= 0:
		velocity.y = velocity.y / 3.0

func handle_movement(delta):
	var frame_acceleration = 0.0
	if input_x_direction:
		frame_acceleration = ACCELERATION * delta
		velocity.x = move_toward(velocity.x, input_x_direction * MAX_SPEED, ACCELERATION * delta)
		# maybe i should put the knockback into a ddifferent move toward function and use an if in between
	else:
		velocity.x = move_toward(velocity.x, 0.0, FRICTION * delta)


func _on_enemy_detector_body_entered(body):
	if 'enemy_name' in body:
		print(body.enemy_name + ' hit you')
