extends KinematicBody2D

var velocity = Vector2()
var _gravity = 0

func shoot(directional_force, gravity):
    velocity = directional_force*5
    _gravity = gravity

func _ready():
    $AnimatedSprite.flip_v = false
    $AnimatedSprite.flip_h = false
    
func set_pos(pos):
    position = pos

func no_collision():
    $CollisionPolygon2D.disabled = true

func _process(delta):
    var new = Phys.new()
    var grav_y = new.grav(velocity.y, delta, _gravity)
    velocity.y = grav_y
    
    $AnimatedSprite.flip_h = (velocity.x > 0)
    position += velocity * delta
    if position.x > 2000 or position.x < 0: # disappears offscreen
        hide()