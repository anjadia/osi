extends TileMap
class_name Platform

# Constants
enum cell_type {
	DIRTY = 0,
	CLEAN = 1,
	WALL = 2,
	POST = 3
}
const allowed_cells = [
	cell_type.DIRTY,
	cell_type.POST
]

onready var platform = $floor
export(Vector2) var spawn := Vector2(0, 0)

# Auxiliary
var dirty_cells_count := INF
var default_cells_ids := Dictionary()

func _ready():
	for cell in platform.get_used_cells():
		default_cells_ids[cell] = platform.get_cellv(cell)
	_update_dirty_cells()


func reset():
	for cell in default_cells_ids:
		platform.set_cellv(cell, default_cells_ids[cell])


func request_move(target):
	if platform.get_cellv(target) in allowed_cells:
		return target
	else:
		return


func lock_tile(target):
	platform.set_cellv(target, cell_type.CLEAN)
	_update_dirty_cells()


func win(target):
	if dirty_cells_count == 0 and platform.get_cellv(target) == cell_type.POST:
		return true
	else:
		return false


#func map_to_world(map_position: Vector2, ignore_half_ofs=false):
#	return .map_to_world(map_position, ignore_half_ofs) \
#		+ Vector2(0, cell_size.y / 2)


#func world_to_map(world_position: Vector2):
#	return .world_to_map(world_position - transform.get_origin())


func to_projection(vector: Vector2):
	# TODO: it can be better...
	return vector.rotated(-PI/4).round()


func _update_dirty_cells():
	dirty_cells_count = platform.get_used_cells_by_id(cell_type.DIRTY).size()
