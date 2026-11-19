extends Control

@onready var short_break = Globals.timer_settings["short_break"]
@onready var long_break = Globals.timer_settings["long_break"]
@onready var study_time = Globals.timer_settings["study"] 

@onready var timer = $Timer

@export var on_break = false 
@export var playing = false

signal break_ended
signal study_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if on_break:
		timer.wait_time = short_break * 60
	else:
		timer.wait_time = study_time * 60
	
	$Label.text = "%02d:%02d" % [study_time, 00]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not timer.is_stopped():
		var time_left: float = timer.time_left
		var minutes: int = int(time_left / 60)
		var seconds: int = int(time_left) % 60
		
		$Label.text = "%02d:%02d" % [minutes, seconds]


func _on_skip_pressed() -> void:
	timer.stop()
	timer.emit_signal("timeout")
	$Play.button_pressed = false

func _on_play_toggled(toggled_on: bool) -> void:
	playing = not playing
	if playing:
		$Timer.start()
	else:
		$Timer.stop()

func _on_timer_timeout() -> void:
	if on_break:
		break_ended.emit()
		on_break = false 
		timer.wait_time = study_time * 60
		$Label.text = "%02d:%02d" % [study_time, 00]
	else:
		study_ended.emit()
		on_break = true
		timer.wait_time = short_break * 60
		$Label.text = "%02d:%02d" % [short_break, 00]
