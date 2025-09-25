extends Area2D

@onready var coin: Node2D = $".."
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	Global.coin += 1
	coin.visible = false
	collision_shape.set_deferred("disabled", true)
	audio_stream_player.play()
