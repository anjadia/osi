extends Pawn
class_name Player


signal win

func _process(_delta):
	_gather_input_events()
	# Check winning condition.
	if grid.win(location):
		emit_signal("win")


func _animate(_delta):
	if is_moving:
		sprite.animation = "walk"
		sprite.play()
	else:
		sprite.animation = "idle"


func _gather_input_events():
	# Reset the game.
	if Input.is_action_just_released("ui_select"):
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	# Move.
	var input_direction = Vector2(
		Input.get_action_strength("ui_right")- Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if input_direction:
		flip(input_direction)
		move(input_direction)
