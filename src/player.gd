extends Pawn
class_name Player

signal win
signal next_level
signal reset_level

var win := false

func _process(_delta):
	_gather_input_events()
	# Check winning condition.
	if grid.win(location):
		win = true
		emit_signal("win")


func _animate(_delta):
	if is_moving:
		sprite.animation = "walk"
		sprite.play()
	else:
		sprite.animation = "idle"


func _gather_input_events():
	# Reset the game.
	if Input.is_action_just_pressed("ui_reset"):
		if not win:
			# warning-ignore:return_value_discarded
			emit_signal("reset_level")
		else:
			emit_signal("next_level")
			win = false
	else:
		# Move.
		var input_direction = Vector2(
			Input.get_action_strength("ui_right")- Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		)
		if input_direction:
			flip(input_direction)
			move(input_direction)
