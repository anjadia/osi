extends RichTextLabel
class_name TimerLabel


var time := 0.0 setget , _get_time

var is_stopped := false

func _process(_delta):
	if not is_stopped:
		time += _delta
		var decimal = int(fmod(time, 1) * 10)
		var seconds = floor(time)
		var minutes = floor(seconds / 60)
		text = "{minutes}:{seconds}:{decimal}".format(
			{
				"minutes": minutes,
				"seconds": seconds,
				"decimal": decimal 
			}
		)


func _on_player_win():
	if not is_stopped:
		is_stopped = true
		print("You have won: %f!" % time)


func _get_time():
	return time
