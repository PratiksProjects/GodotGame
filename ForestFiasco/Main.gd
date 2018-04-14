extends Node

export (PackedScene) var Gobbo

func _ready():
    $Player.hide()
func new_game():
    $Player.start($StartPosition.position)
    var s = Summator.new()
    s.add(10)
    s.add(20)
    s.add(30)
    print(s.get_total())
    s.reset()
    
