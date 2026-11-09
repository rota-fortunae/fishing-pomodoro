extends Node2D

@export var saving = false

# "name": [regular, gold, shiny]
@onready var inventory_fish = {
	"seaweed": [1, 0, 0]
}

@onready var fishing_streak = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
