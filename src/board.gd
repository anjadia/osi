extends TileMap

class_name Board


func _ready():
	pass


func request_move(target_position):
	return map_to_world(to_projection(target_position))


func map_to_world(map_position, ignore_half_ofs=false):
	return .map_to_world(map_position, ignore_half_ofs) \
		+ transform.get_origin() \
		+ Vector2(0, cell_size.y / 2)


func world_to_map(world_position):
	return .world_to_map(world_position - transform.get_origin())


func to_projection(vector):
	# TODO: it can be better...
	return vector.rotated(-PI/4).round()
