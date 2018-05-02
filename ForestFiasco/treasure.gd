extends RigidBody2D

func _ready():
    $AnimatedSprite.animation = "default"

func _on_Visibility_screen_exited():
    queue_free()
    
func _on_RigidBody2D_body_entered(body):
   pass
