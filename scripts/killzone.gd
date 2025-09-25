extends Area2D

@onready var timer = $Timer
const Chara = preload("res://scripts/chara.gd")
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func deth() -> void:

	Global.coin = 0
	Global.die = false
	Global.life-= 1
	if Global.life >= 0:
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene_to_file("res://sceens/Gameover.tscn")

func _on_body_entered(body: Node2D) -> void:
	Global.die = true
	audio_stream_player.play()
	timer.start()

func _on_timer_timeout() -> void:
	deth()
