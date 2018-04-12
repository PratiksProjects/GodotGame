extends Node

export (PackedScene) var Gobbo

func _ready():
    pass
func new_game():
    $Player.start($StartPosition.position)