extends Node2D

class_name Pawn

# Because the origin of a pawn is always placed in cells' top corner,
# its children nodes can be aligned, if needed.
export(Vector2) var cell_alignment
# Used for preplacing the pawn.
export(Vector2) var spawn
# Movement speed in px/s.
export(int) var speed

# tmp (?)
onready var grid = get_node("/root/scene/board")

# 'Location' is a grid related placement of a pawn,
# whereas built-in 'position' corresponds to its pixel coordinates.
var location := Vector2()
# State machine, some kind.
var is_moving := false

var distance := Vector2()
var velocity := Vector2()


func _ready():
	place_to(spawn)
	for child in get_children():
		child.transform.origin += cell_alignment


func _process(delta):
	# Debug
	grid.set_cellv(location, 0)
	location = grid.world_to_map(position)
	# Debug
	grid.set_cellv(location, 1)

	var movement = velocity * delta
	if movement:
		position += velocity * delta	


func move(direction):
	if direction:
		var new_position = grid.request_move(location + direction)
		if new_position:
			velocity = (direction * grid.cell_size).normalized() * speed
	else:
		velocity = Vector2.ZERO


func place_to(new_location):
	location = new_location
	position = grid.map_to_world(location)
