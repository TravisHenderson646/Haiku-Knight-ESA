extends Area2D

@onready var hurtbox_shape = $HurtboxShape
@onready var polygon_2d = $HurtboxShape/Polygon2D

func _ready():
	polygon_2d.polygon = hurtbox_shape.polygon


func activate_sword():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	
func deactivate_sword():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
