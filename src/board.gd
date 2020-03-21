extends TileMap
class_name Board

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
# Auxiliary
var dirty_cells_count := 0


func _ready():
	_update_dirty_cells()


func request_move(target):
	if get_cellv(target) in allowed_cells:
		return target
	else:
		return


func lock_tile(target):
	set_cellv(target, cell_type.CLEAN)
	_update_dirty_cells()


func win(target):
	if dirty_cells_count == 0 and get_cellv(target) == cell_type.POST:
		return true
	else:
		return false


func map_to_world(map_position: Vector2, ignore_half_ofs=false):
	return .map_to_world(map_position, ignore_half_ofs) \
		+ transform.get_origin() \
		+ Vector2(0, cell_size.y / 2)


func world_to_map(world_position: Vector2):
	return .world_to_map(world_position - transform.get_origin())


func to_projection(vector: Vector2):
	# TODO: it can be better...
	return vector.rotated(-PI/4).round()


func _update_dirty_cells():
	dirty_cells_count = get_used_cells_by_id(cell_type.DIRTY).size()
