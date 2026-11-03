extends Node

var directions = {1: "up", 2: "down", 3: "right", 4: "left"}
var fisher_location = Vector2(32, 72)
var fishing = false
var sprite_list = []
var arrow_list = []

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not fishing && Input.is_action_just_pressed("up"):
		fishing = true
		print("starting fishing")
		start_fishing()
		return
		
	if fishing and arrow_list.size() > 0:
		var pressed = ""
		if Input.is_action_just_pressed("up"): pressed = "up"
		elif Input.is_action_just_pressed("down"): pressed = "down"
		elif Input.is_action_just_pressed("left"): pressed = "left"
		elif Input.is_action_just_pressed("right"): pressed = "right"
			
		if pressed != "":
			if arrow_list[0] == pressed:
				$AudioStreamPlayer.stream=load("res://art/ding.mp3")
				$AudioStreamPlayer.play()
				arrow_list.pop_at(0)
				var correct_sprite = sprite_list.pop_at(0)
				correct_sprite.queue_free()
				
				var tween = create_tween().set_parallel(true)
				for i in range(sprite_list.size()):
					tween.tween_property(sprite_list[i], "position", sprite_list[i].position - Vector2(18, 0), 0.15).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			else:
				$AudioStreamPlayer.stream=load("res://art/fail.mp3")
				$AudioStreamPlayer.play()
				print("failed game")
				for i in range (len(arrow_list)):
					arrow_list.pop_at(0)
					sprite_list.pop_at(0).queue_free()

		if arrow_list.size() == 0:
			fishing = false

func start_fishing():
	arrow_list = []
	sprite_list = []
	
	for i in range(randi_range(2, 10)):
		arrow_list.append(directions[randi_range(1, 4)])
	print(arrow_list)
	
	for arrow_index in range(arrow_list.size()):
		var new_sprite = Sprite2D.new()
		sprite_list.append(new_sprite)
		add_child(new_sprite)
		
		new_sprite.texture = load("res://art/" + arrow_list[arrow_index] + "_arrow.png")
		new_sprite.position = fisher_location + Vector2(18 * (arrow_index + 1), 0)
		new_sprite.visible = true
