extends Node2D
class_name Game

onready var player = $player
onready var timer = $ui/timer_label

func _ready():
	player.connect("win", timer, "_on_player_win")
