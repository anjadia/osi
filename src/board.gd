extends TileMap

class_name Board

export(Vector2) var dimension = Vector2(8, 8)


var locked_tiles := Array()


func _ready():
	pass


func request_move(target):
	if target.x < 0 or target.x >= dimension.x:
		return
	if target.y < 0 or target.y >= dimension.y:
		return
	if target in locked_tiles:
		return
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
	set_cellv(target, 3)
