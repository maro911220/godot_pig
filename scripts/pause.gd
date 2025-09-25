extends Control
@onready var resume_btn: Button = $MarginContainer/VBoxContainer/Resume
@onready var restart_btn: Button = $MarginContainer/VBoxContainer/Restart
@onready var quit_btn: Button = $MarginContainer/VBoxContainer/Quit

var paused: bool = false

func _ready() -> void:
	#visible = false
	# 제외 처리
	get_tree().connect("tree_changed", _on_scene_changed)
	_on_scene_changed() 
	# 버튼 연결
	resume_btn.pressed.connect(_on_resume_pressed)
	restart_btn.pressed.connect(_on_restart_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)

# 제외 처리 함수
func _on_scene_changed() -> void:
	var tree = get_tree()
	# tree가 null이 아닌지 먼저 확인합니다.
	if tree:
		var current_scene = tree.current_scene
		if current_scene:
			# 씬의 이름을 확인하는 로직은 여기에 위치합니다.
			if current_scene.name == "Menu":
				set_process_unhandled_input(false)
				visible = false
			else:
				set_process_unhandled_input(true)
				visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if paused:
			hide_pause()
		else:
			show_pause()

func show_pause() -> void:
	visible = true
	get_tree().paused = true
	resume_btn.grab_focus()
	paused = true

func hide_pause() -> void:
	visible = false
	get_tree().paused = false
	paused = false

func _on_resume_pressed() -> void:
	hide_pause()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
