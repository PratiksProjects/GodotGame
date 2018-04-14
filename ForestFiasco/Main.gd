extends Node

export (PackedScene) var Gobbo

func _ready():
    $Player.hide()
func new_game():
    $Player.start($StartPosition.position)
