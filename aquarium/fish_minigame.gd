extends Node

var directions = {1: "up", 2:"down", 3:"right", 4:"left"}
var fisher_location = Vector2(32, 72)
var fishing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not fishing && Input.is_action_pressed("up"):
		fishing = true
		print("starting fishing")
		start_fishing()

func start_fishing():
	var arrow_list = []
	for i in range(randi_range(2, 10)):
		arrow_list.append(directions[randi_range(1, 4)])
	print(arrow_list)
	
	#shoulda made this a queue actually 
	var sprite_list = []
	var counter = 1
	for arrow in range(len(arrow_list)):
		counter += 1
		sprite_list.append(Sprite2D.new())
		add_child(sprite_list[arrow])
		sprite_list[arrow].texture = load("res://art/"+arrow_list[arrow]+"_arrow.png")
		sprite_list[arrow].position = fisher_location + Vector2(18 * counter, 0)
		sprite_list[arrow].visible=true

	
	
