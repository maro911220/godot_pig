extends Area2D

@onready var timer: Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_bg: AudioStreamPlayer = $"../AudioStreamPlayer"

func _on_body_entered(body: Node2D) -> void:
	Global.clear = true
	Global.stage += 1
	audio_stream_player_bg.stop()
	audio_stream_player.play()
	timer.start()
	
func _on_timer_timeout() -> void:
	if(Global.stage <= 1):
		Global.clear = false
		get_tree().change_scene_to_file("res://Stage-"+str(Global.stage)+".tscn")
	else:
		Global.stage = 1
		get_tree().change_scene_to_file("res://sceens/GameClear.tscn")
