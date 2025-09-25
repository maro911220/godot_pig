extends Control

@onready var start: Button = $Start
@onready var exit: Button = $Exit

func _ready() -> void:
	start.grab_focus() 
	start.pressed.connect(_on_start)
	exit.pressed.connect(_on_quit)
	
# 첫 시작 시 라이프 초기화 -> 스테이지로 이동
func _on_start() -> void:
	Global.life = 5
	Global.coin = 0
	Global.clear = false
	get_tree().change_scene_to_file("res://Stage-1.tscn")

func _on_quit() -> void:
	get_tree().quit()
