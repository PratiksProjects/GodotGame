extends Node

export (PackedScene) var Gobbo
export (PackedScene) var platform

func _ready():
    $Player.hide()
func new_game():
    $Player.start($StartPosition.position)
    
