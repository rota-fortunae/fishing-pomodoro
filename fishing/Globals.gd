extends Node2D

@export var saving = false

# "name": [regular, gold, shiny]
@onready var inventory_fish = {
	
}

signal any_key_pressed

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		any_key_pressed.emit()



@onready var fishing_streak = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal fish_caught(fish_name: String, is_new: bool)

func caught_fish(fish: String, new_fish: bool):
	if new_fish:
		inventory_fish[fish] = [1, 0, 0]
		
	else:
		inventory_fish[fish][0] += 1 
	
	fishing_streak += 1

	fish_caught.emit(fish, new_fish)

	
	
