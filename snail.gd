extends CharacterBody2D

var enemy_name = 'snail'
@onready var animated_sprite_2d = $AnimatedSprite2D
const SPEED = 30.0
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_wall():
		direction = direction * -1
		animated_sprite_2d.flip_h = not animated_sprite_2d.flip_h

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_sword_detector_area_entered(area):
	print('You hit me -Love snail')
