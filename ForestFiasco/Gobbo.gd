extends RigidBody2D
var i = 0
export (int) var speed
var direction = Vector2(2,0)
func _ready():
    $AnimatedSprite.animation = "right"


func _process(delta):
    position +=direction
    if(position.x >= 500 and i == 0):
        i = 1
        direction=-1*direction
        $AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
    else:
        if(position.x <= 100 and i == 1):
            i = 0
            direction=-1*direction
            $AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
        else:
            position += direction

func _on_Visibility_screen_exited():
    queue_free()