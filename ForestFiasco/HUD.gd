extends CanvasLayer

signal start_game

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func show_game_over():
    show_message("Game Over")
    yield($MessageTimer, "timeout")
    $Button.show()
    $MessageLabel.text = "Game Time!"
    $MessageLabel.show()


func show_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass


func _on_Button_pressed():
    $Button.hide()
    emit_signal("start_game")
    


func _on_MessageTimer_timeout():
    $MessageLabel.hide()
