extends Node

export (PackedScene) var Gobbo
export (PackedScene) var platform
var stat = Hpmp.new()

func _ready():
    $Area2D/Player.hide()
func new_game():
    $Area2D/Player.start($StartPosition.position)
    
func _process(delta):
    $Area2D/CollisionShape2D.position=$Area2D/Player.position

func _on_Area2D_body_entered(body):
    print("hit")
    if(body.get_name() == "gobboChild"):
#        hide()
        $Area2D/Player.hp = stat.stats(0,-5)
        print($Area2D/Player.hp)
        $Area2D/Player/Camera2D/HPBar.set_value($Area2D/Player.hp)
    elif(body.get_name() == "platformChild"):
         $Area2D/Player.velocity.y -=  $Area2D/Player.GRAVITY
    else:
        print("not gobbo or platform")
    #$CollisionShape2D.disabled = true
    if( $Area2D/Player.hp<=0):
        $Area2D/Player.hide()
        $Area2D/CollisionShape2D.disabled = true
        $Area2D/Player.dead=1
#func overlaps_body(body):
#    if(body.get_name() == "platformChild"):
#        velocity.y -= GRAVITY
#    else:
#        print("not gobbo or platform")
#    $CollisionShape2D.disabled = true
    

