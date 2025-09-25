extends Node

var clear: bool = false
var die: bool = false
var stage:int = 1
var life: int = 3 : set = set_life
var coin: int = 0 : set = set_coin
signal life_changed(new_life)
signal coin_changed(new_coin)
func set_life(value: int) -> void:
	life = value
	emit_signal("life_changed", life)

func set_coin(value: int) -> void:
	coin = value
	emit_signal("coin_changed", coin)
