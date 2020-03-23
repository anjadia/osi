extends RichTextLabel
class_name TimerLabel


onready var time := 0.0 setget , _get_time
onready var is_stopped := false


func _ready():
	rect_position = Vector2(0, 0)


func _process(_delta):
	if not is_stopped:
		time += _delta
		text = _format_time()


func _on_player_win():
	if not is_stopped:
		is_stopped = true
		text = "You've cleaned all the tiles in {time}.".format(
			{ "time": _format_time(100) }
		)
		#rect_position = (OS.get_window_size() - rect_size) / 2


func _get_time():
	return time


func _format_time(precision=10):
	var partial = int(fmod(time, 1) * precision)
	var seconds = floor(time)
	var minutes = floor(seconds / 60)
	return "{minutes}:{seconds}:{partial}".format(
			{
				"minutes": minutes,
				"seconds": seconds,
				"partial": partial
			}
		)

func reset():
	time = 0.0
	is_stopped = false
