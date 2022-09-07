extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animationplayer = $AnimationPlayer
onready var hitbox = $Attack_hitbox
onready var block = $Block

func _ready():
	self.visible = true
	self.hitbox.disabled = true
	$Block_hitbox.disabled = true
	self.block.visible = false
	$AnimationPlayer.get_animation("swing").length = 0.2
	self.connect("body_entered", self, "handle_collision")

func attack():
	if not self.visible:
		self.visible = true
	self.animationplayer.play("swing")
	
func handle_collision(body):
	if body is Player:
		return
	if body is Enemy:
		body.health.current_value -= 10
		return
	if body is Drone:
		body.health.current_value -= 10
		return

