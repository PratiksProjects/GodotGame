extends CanvasLayer

signal start_game

func show_game_over():
    show_message("Game Over")
    $CreatorLabel.text = "You have died!"
    $CreatorLabel.show()

func show_winner():
    show_message("Winner!")
    $CreatorLabel.text = "You got the treasure!"
    $CreatorLabel.show()

func show_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()

func _ready():
    $MessageLabel.text = "Forest Fiasco!"
    $CreatorLabel.text = "Created By: Milo Pan, Pratik Sharma, and Brandon Weiner"

func _on_Button_pressed():
    $Button.hide()
    $MessageLabel.hide()
    $CreatorLabel.hide()
    $CanvasLayer/ColorRect.hide()
    emit_signal("start_game")
    


func _on_MessageTimer_timeout():
    $MessageLabel.hide()
