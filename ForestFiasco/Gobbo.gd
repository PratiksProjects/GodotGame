extends RigidBody2D
var i = 0
export (int) var speed
var direction = Vector2(2,0)
var init
func _ready():
    $AnimatedSprite.animation = "right"
    init = position

func _process(delta):
    if (position.x!=null):
        position +=direction
        if(position.x >= init.x+100 and i == 0):
            i = 1
            direction=-1*direction
            $AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
        else:
            if(position.x <= init.x-100 and i == 1):
                i = 0
                direction=-1*direction
                $AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
            else:
                position += direction

func _on_Visibility_screen_exited():
    queue_free()