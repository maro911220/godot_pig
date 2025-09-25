extends CanvasLayer

@onready var label: Label = $Label
@onready var label_coin: Label = $Label_coin


func _ready() -> void:
	get_tree().connect("tree_changed", _on_scene_changed)
	_on_scene_changed() 
	label.text = "x" + str(Global.life)
	label_coin.text = "x" + str(Global.coin)
	Global.life_changed.connect(_on_life_changed)
	Global.coin_changed.connect(_on_coin_changed)

func _on_life_changed(new_life: int) -> void:
	label.text = "x" + str(new_life)

func _on_coin_changed(new_coin: int) -> void:
	label_coin.text = "x" + str(new_coin)

# 제외 처리 함수
func _on_scene_changed() -> void:
	var tree = get_tree()
	# tree가 null이 아닌지 먼저 확인합니다.
	if tree:
		var current_scene = tree.current_scene
		if current_scene:
			# 씬의 이름을 확인하는 로직은 여기에 위치합니다.
			if current_scene.name == "Menu":
				visible = false
			else:
				visible = true
