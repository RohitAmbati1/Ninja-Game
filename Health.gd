extends Node

signal health_reach_zero

var max_value:int = 100
var current_value:int = 100 setget set_value
var min_value:int = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_value(new_value):
	current_value = clamp(new_value, min_value, max_value)
	if current_value == 0:
		emit_signal("health_reach_zero")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
