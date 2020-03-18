extends Pawn

class_name Player


func _ready():
	pass


func _process(_delta):
	var input_direction = get_input_direction()
	move(input_direction)


func get_input_direction():
	return Vector2(
		Input.get_action_strength("ui_right")- Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)