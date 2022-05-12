extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animationplayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	$AnimationPlayer.get_animation("swing").length = 0.2
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func attack():
	if not self.visible:
		self.visible = true
	self.animationplayer.play("swing")
func action():
	self.visible = not self.visible
