extends Node2D
class_name Game

onready var player = $platform/player
onready var timer = $ui/timer_label
onready var current_scene = $platform
onready var background = $background

var scenes = [
	"res://scenes/platform_02.tscn"
]

func _ready():
	_resized()
	player.spawn = current_scene.spawn
	player.connect("win", timer, "_on_player_win")
	player.connect("next_level", self, "_on_player_win")
	player.connect("reset_level", self, "_on_player_reset")
	_on_player_reset()


func _enter_tree():
	# warning-ignore:return_value_discarded
	get_tree().get_root().connect("size_changed", self, "_resized")


func _resized():
	var window_size = OS.get_window_size()
	current_scene.transform.origin = window_size * Vector2(0.5, 0.3)
	player.place_to(player.location)
	var background_rect = PoolVector2Array([
		Vector2(0, 0),
		Vector2(window_size.x, 0),
		window_size,
		Vector2(0, window_size.y)
	])
	background.polygon = background_rect


func _on_player_win():
	var next_scene_path = _get_next_scene()
	if next_scene_path:
		var next_scene = load(next_scene_path).instance()
		next_scene.transform = current_scene.get_transform()
		current_scene.remove_child(player)
		next_scene.add_child(player)
		next_scene.move_child(player, 0)
		self.add_child(next_scene)
		self.remove_child(current_scene)
		current_scene = next_scene
		player.spawn = current_scene.spawn
		player.grid = current_scene
		_on_player_reset()


func _on_player_reset():
	current_scene.reset()
	timer.reset()
	player.reset()


func _get_next_scene():
	return scenes.pop_front()
