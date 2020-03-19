extends Node2D

class_name Pawn

# Because the origin of a pawn is always placed in cells' top corner,
# its children nodes can be aligned, if needed.
export(Vector2) var cell_alignment
# Used for preplacing the pawn.
export(Vector2) var spawn = Vector2(0, 0)
# Movement speed in px/s.
export(int) var speed = 32

# tmp (?)
onready var grid = get_node("/root/scene/board")
onready var step_size = grid.cell_size

# 'Location' is a grid related placement of a pawn,
# whereas built-in 'position' corresponds to its pixel coordinates.
var location := Vector2()
# Look direction of a pawn.
var lookahead := Vector2()
# State machine, some kind.
var is_moving := false

var movement := Vector2()
var velocity := Vector2()
var distance := Vector2()
var guide := Vector2()

# Auxiliary variables.
var target_location := Vector2()


func _ready():
	place_to(spawn)
	for child in get_children():
		child.transform.origin += cell_alignment


func _process(delta):
	_move(delta)
	update()


func _draw():
	if is_moving:
		draw_line(
			Vector2(0, 0),
			grid.map_to_world(target_location) - position,
			Color(255, 0, 0),
			2
		)
	grid.set_cellv(location, 1) # Debug
	if target_location:
		grid.set_cellv(target_location, 2) # Debug


func move(direction):
	# It's impossible to change movement direction (by now ?).
	if not is_moving:
		target_location = location + grid.to_projection(direction)
		distance = grid.map_to_world(target_location) - position
		velocity = distance.normalized() * speed
		movement = Vector2.ZERO
		is_moving = true


func place_to(new_location):
	location = new_location
	position = grid.map_to_world(location)


func _move(delta):
	if is_moving:
		var step = velocity * delta 
		movement += velocity * delta
		if movement.abs() < distance.abs():
			position += step
		else:
			grid.set_cellv(location, 0) # Debug
			velocity = Vector2.ZERO
			distance = Vector2.ZERO
			movement = Vector2.ZERO
			location = target_location
			position = grid.map_to_world(location)
			target_location = Vector2.ZERO
			is_moving = false
