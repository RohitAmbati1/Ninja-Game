extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var FPS = $Margin/Label



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.FPS.text = "FPS: " + str(Engine.get_frames_per_second())
