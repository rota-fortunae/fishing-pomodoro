extends Control

@onready var short_break = Globals.timer_settings["short_break"]
@onready var long_break = Globals.timer_settings["long_break"]
@onready var study_time = Globals.timer_settings["study"] 

@export var on_break = false 
@export var playing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if on_break:
		$Timer.wait_time = short_break
	else:
		$Timer.wait_time = study_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#$Label.asdfahwelihfidslfha;lisd

func start_playing():
	$Timer.start()
	
