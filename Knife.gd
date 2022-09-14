extends Area2D

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
	
func _physics_process(delta):
	if Input.is_action_just_pressed("draw"):
		self.toggle_block()
		
func toggle_block():
	if self.block.visible == true:
		self.unblock()
	else:
		self.block()

func unblock():
	self.animationplayer.play("unblock")

func block():
	if not self.visible:
		self.visible = true
	self.animationplayer.play("block")

func handle_collision(body):
	if body is Player:
		return
	if body is Enemy:
		body.health.current_value -= 10
		return
	if body is Drone:
		body.health.current_value -= 10
		return

