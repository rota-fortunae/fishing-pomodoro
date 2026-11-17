extends CharacterBody2D

@export var speed = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Sprite2D
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	print("left wall:" + str($"../LeftWall".position))
	print("right wall:" + str($"../RightWall".position))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	pass

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	
	move_and_slide()
	
	if is_on_wall():
		print("collided")
		direction *= -1
		sprite.flip_h = (direction < 0)
