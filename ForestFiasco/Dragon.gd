extends RigidBody2D
var i = 0
export (int) var speed
var direction = Vector2(2,0)
var init
func _ready():
    $AnimatedSprite.animation = "default"
    init = position
    $AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

func _on_Visibility_screen_exited():
    queue_free()