extends Node2D

const SPEED = 60

var direction = -1
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var monster: Node2D = $"."
@onready var collision_shape: CollisionShape2D = $Killzone/CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	if ray_cast_up.is_colliding():
		var target = ray_cast_up.get_collider()
		target.velocity.y = -200
		animated_sprite_2d.visible = false
		ray_cast_up.enabled = false
		collision_shape.set_deferred("disabled", true)
		audio_stream_player.play()
		
	position.x += direction * SPEED * delta
