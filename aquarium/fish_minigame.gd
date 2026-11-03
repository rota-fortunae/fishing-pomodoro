extends Node

var directions = {1: "up", 2:"left", 3:"right", 4:"left"}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_fishing():
	var arrow_list = []
	for i in range(randi_range(2, 10)):
		for j in range(randi_range(1, 4)):
			arrow_list.append(directions[j])
	print(arrow_list)
	
	
	
