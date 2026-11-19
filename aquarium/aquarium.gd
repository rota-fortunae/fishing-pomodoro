extends Control

@onready var current_fish_list = []
@onready var possible_fish_list = []
@onready var fish_nodes = []
@onready var inventory_fish = Globals.inventory_fish

@onready var spawn_area = 5500 # add a fish if there's this much room for one more
@onready var despawn_area = 5000 # remove fish if each has less than this


func flatten_fish():
	for i in inventory_fish.keys():
		
		for j in 3:
			for x in range(int(inventory_fish[i][j])):
				possible_fish_list.append([i, j])

func fill_aquarium() -> void:
	var window = get_viewport_rect().size
	var area = window.x * window.y

	while (fish_nodes.size() + 1) * spawn_area <= area and possible_fish_list.size() > 0:
		spawn_one_fish(get_random_fish())

	while fish_nodes.size() * despawn_area > area and fish_nodes.size() > 0:
		despawn_one_fish()

func _ready() -> void:
	get_tree().get_root().size_changed.connect(_on_window_resized)
	$RightWall.position.x = get_viewport_rect().size.x - 3
	flatten_fish()
	fill_aquarium()

func _on_window_resized() -> void:
	$RightWall.position.x = get_viewport_rect().size.x - 3
	fill_aquarium()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
	
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
	
	fish.name = fish_name
	
	fish_nodes.append(fish)
	add_child(fish)
	
func get_random_fish():
	var index = randi_range(0, possible_fish_list.size() - 1)
	var f = possible_fish_list.pop_at(index)
	current_fish_list.append(f)  
	return f[0]

func despawn_one_fish():
	var ind = 0
	for i in range(fish_nodes.size()):
		if fish_nodes[i].position.x > fish_nodes[ind].position.x:
			ind = i
	possible_fish_list.append(current_fish_list.pop_at(ind))
	fish_nodes.pop_at(ind).queue_free()
	
	



	
