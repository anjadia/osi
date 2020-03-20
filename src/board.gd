extends TileMap

class_name Board

onready var sound = get_node("./sound")

export(Vector2) var dimension = Vector2(8, 8)

var locked_tiles := Array()

const WALL = 2
const FINISH = 3

func _ready():
	for x in range(dimension.x):
		for y in range(dimension.y):
			var tile_type = get_cell(x, y)
			if tile_type == WALL:
				locked_tiles.append(Vector2(x, y))


func win(target):
	if get_cellv(target) == FINISH and \
		locked_tiles.size() == dimension.x * dimension.y - 1:
		return true
	else:
		return false


func request_move(target):
	if target.x < 0 or target.x >= dimension.x or \
		target.y < 0 or target.y >= dimension.y or \
		target in locked_tiles:
			sound.get_node("locked").play()
			return
	else:
		sound.get_node("bell").play()
		return target


func map_to_world(map_position, ignore_half_ofs=false):
	return .map_to_world(map_position, ignore_half_ofs) \
		+ transform.get_origin() \
		+ Vector2(0, cell_size.y / 2)


func world_to_map(world_position):
	return .world_to_map(world_position - transform.get_origin())


func to_projection(vector):
	# TODO: it can be better...
	return vector.rotated(-PI/4).round()


func lock_tile(target):
	locked_tiles.append(target)
	set_cellv(target, 1)
