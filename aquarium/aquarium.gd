extends Control

@onready var current_fish_list = []
@onready var possible_fish_list = []
@onready var fish_nodes = []
@onready var inventory_fish = Globals.inventory_fish
@onready var count = 0

func sum_fish():
	var count = 0
	for i in inventory_fish.keys():
		count += (inventory_fish[i]).reduce(func(accum, number): return accum + number, 0)
		
		for j in 3:
			for x in range(int(inventory_fish[i][j])):
				possible_fish_list.append([i, j])
		
	return count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().size_changed.connect(_on_window_resized)
	$RightWall.position.x = get_viewport_rect().size.x - 3
	print("wallpos = "+ str(get_viewport_rect().size.x - 3))
	count = sum_fish()
	spawn_one_fish(get_random_fish())
	spawn_one_fish(get_random_fish())
	spawn_one_fish(get_random_fish())
	spawn_one_fish(get_random_fish())
	spawn_one_fish(get_random_fish())
	spawn_one_fish(get_random_fish())
	

func _on_window_resized() -> void:
	var new_size: Vector2i = get_viewport_rect().size
	$RightWall.position.x = new_size.x - 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_random_fish():
	var index = randi_range(0, sum_fish()-1)
	
	#remember that this doesn't return information about shiny types!
	
	var f = possible_fish_list[index]
	print(f)
	count += 1
	possible_fish_list.pop_at(index)
	current_fish_list.append([f])
	return f[0]
	
	
	
	
func spawn_one_fish(fish_name : String):
	
	
	var window = get_viewport_rect().size
	var fish = load("res://aquarium/aquarium_fish.tscn").instantiate()
	
	
	fish.get_node("Sprite2D").texture = load("res://art/fish/" + fish_name + ".png")
	var sprite_size = fish.get_node("Sprite2D").get_rect().size
	
	fish.visible = true

	#spawnposition varied on y axis and confined to border on right x axis
	fish.position = Vector2(window.x - 4 - sprite_size.x, randi_range(6 + sprite_size.y, window.y - sprite_size.y - 13))
	print(str(fish.position) + "is the position of the fish ") 
	
	#randomized speed (varies in 20% in either direction)
	fish.speed = randi_range(Globals.fish_speed - int(Globals.fish_speed /5), Globals.fish_speed + int(Globals.fish_speed /5))
	
	fish.get_node("CollisionShape2D").shape.size = sprite_size
	
	fish_nodes.append(fish)
	add_child(fish)
	
	
	
