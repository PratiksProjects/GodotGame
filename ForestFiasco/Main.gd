extends Node

export (PackedScene) var Gobbo
export (PackedScene) var GobboCenturion
export (PackedScene) var Shadow
export (PackedScene) var platform
var stat = Hpmp.new()

var playerID = 1210

func _ready():
    $Area2D/Player.hide()
func new_game():
    $Area2D/Player.start($StartPosition.position)
    
func _process(delta):
    # need one for every new mob
    $Area2D/CollisionShape2D.position=$Area2D/Player.position
    $gobbo/CollisionShape2D.position = $gobbo/gobboChild.position
    $gobboCenturion/CollisionShape2D.position = $gobboCenturion/gobboCenturionChild.position
    $shadow/CollisionShape2D.position = $shadow/shadowChild.position
    $dragon/CollisionShape2D.position = $dragon/dragonChild.position
    stat.update($Area2D/Player.hp, $Area2D/Player.mp)
    $Area2D/Player/Camera2D/HPBar.set_value($Area2D/Player.hp)
    $Area2D/Player/Camera2D/MPBar.set_value($Area2D/Player.mp)
    

func _on_Area2D_body_entered(body):
    if(body.get_name() == "gobboChild"):
        $Area2D/Player.hp = stat.stats(0,-5)    
    elif(body.get_name() == "gobboCenturionChild"):
        $Area2D/Player.hp = stat.stats(0,-20)
    elif(body.get_name() == "shadowChild"):
        $Area2D/Player.hp = stat.stats(0,-40)
        $Area2D/Player.mp = stat.stats(1,-10)
    elif(body.get_name() == "dragonChild"):
        $Area2D/Player.hp = stat.stats(0,-99)
        $Area2D/Player.mp = stat.stats(1,-20)
    elif(body.get_name() == "platformChild"):
        $Area2D/Player.velocity.y -=  $Area2D/Player.GRAVITY
    elif(body.get_name() == "hppotion"):
        $Area2D/Player.hp = stat.stats(0,25)
        body.hide()
        body.set_collision_mask_bit(0,false)
        print("potion")
    elif(body.get_name() == "mppotion"):
        $Area2D/Player.mp = stat.stats(1,25)
        body.hide()
        body.set_collision_mask_bit(0,false) 
    elif(body.get_name() == "treasure"):
        $TitleScreen.show_winner()
        body.hide()
        body.set_collision_mask_bit(0,false)  
        $Area2D/Player.hide()
        $Area2D/CollisionShape2D.disabled = true
        $Area2D/Player.dead = 1
        print("You win!")
    else:
        print("collision not recognized")
        
    if( $Area2D/Player.hp<=0):
        $Area2D/Player.hide()
        $Area2D/CollisionShape2D.disabled = true
        $Area2D/Player.dead = 1
        $TitleScreen.show_game_over()
        print("You are dead!")

func _on_gobbo_body_shape_entered(body_id, body, body_shape, area_shape):
    if body_id != playerID: 
        print("Killed gobbo")
        $gobbo/gobboChild.hide()
        $gobbo/gobboChild/CollisionShape2D.disabled = true
        $gobbo/CollisionShape2D.disabled = true
        body.hide()
        body.no_collision()

func _on_gobboCenturion_body_shape_entered(body_id, body, body_shape, area_shape):
    if body_id != playerID:
        print("Killed gobbo centurion")
        $gobboCenturion/gobboCenturionChild.hide()
        $gobboCenturion/gobboCenturionChild/CollisionShape2D.disabled = true
        $gobboCenturion/CollisionShape2D.disabled = true
        body.hide()
        body.no_collision()

func _on_shadow_body_shape_entered(body_id, body, body_shape, area_shape):
    if body_id != playerID: 
        print("Killed shadow")
        $shadow/shadowChild.hide()
        $shadow/shadowChild/CollisionShape2D.disabled = true
        $shadow/CollisionShape2D.disabled = true
        body.hide()
        body.no_collision()

func _on_dragon_body_shape_entered(body_id, body, body_shape, area_shape):
    if body_id != playerID: 
        print("Killed dragon")
        $dragon/dragonChild.hide()
        $dragon/dragonChild/CollisionShape2D.disabled = true
        $dragon/CollisionShape2D.disabled = true
        body.hide()
        body.no_collision()

# also need one for every new mob
