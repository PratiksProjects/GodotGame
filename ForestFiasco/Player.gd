extends KinematicBody2D

signal hit
export (int) var SPEED

var screensize
const GRAVITY = 150
var velocity = Vector2() # the player's movement vector

var on_air_time = 0
var jumping = false
var prev_jump_pressed = false

var stat = Hpmp.new()
var dead = false
var hp = 100

const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 1500
const JUMP_MAX_AIRBORNE_TIME = 0.2

const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

func _ready():
    screensize = get_viewport_rect().size
    
#TEST    
func _process(delta):
    if not dead:
        var force = Vector2(0, GRAVITY)

        var new = Phys.new()
        var grav_y = new.grav(velocity.y, delta, GRAVITY)
        velocity.y = grav_y

        var move_left = Input.is_action_pressed("ui_left")
        var move_right = Input.is_action_pressed("ui_right")
        var jump = Input.is_action_pressed("ui_up")

        var stop = true

        if move_right:
            if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
                force.x += WALK_FORCE
                stop = false
        elif move_left:
            if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
                force.x -= WALK_FORCE
                stop = false
 
        
        if stop:
            var vsign = sign(velocity.x)
            var vlen = abs(velocity.x)
        
            vlen -= STOP_FORCE * delta
            if vlen < 0:
                vlen = 0
            velocity.x = vlen * vsign

        velocity += force * delta

        #---------------------------------------
        velocity = move_and_slide(velocity, Vector2(0, -1))

        if is_on_floor():
            on_air_time = 0
        if jumping and velocity.y > 0:
            # If falling, no longer jumping
            jumping = false
        #--------------------------------------
        
        
        #print(on_air_time)

        if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
            # Jump must also be allowed to happen if the character left the floor a little bit ago.
            # Makes controls more snappy.
            velocity.y = -JUMP_SPEED
            jumping = true
    
        on_air_time += delta
        prev_jump_pressed = jump


        if velocity.length() > 0:
           $AnimatedSprite.play()
        else:
            $AnimatedSprite.stop()



        position.x = clamp(position.x, 0, 2000)
        #position.y = clamp(position.y, 0, 250)
        velocity.y = clamp(velocity.y, -200, 100)
        
        if velocity.x >= 0 && velocity.x < 5 && velocity.y <= 100 && velocity.y > 95:
             $AnimatedSprite.animation = "default"
        elif abs(velocity.y)>5:
            $AnimatedSprite.animation = "up"
        else:
            $AnimatedSprite.animation = "right"
            $AnimatedSprite.flip_v = false
            $AnimatedSprite.flip_h = velocity.x < 0
       

        #velocity.x = 0

#func _on_Player_body_entered(body):
#
#    if(body.get_name() == "gobboChild"):
##        hide()
#        hp = stat.stats(0,-99)
#        print(hp)
#        $Camera2D/HPBar.set_value(hp)
#    elif(body.get_name() == "platformChild"):
#        velocity.y -= GRAVITY
#    else:
#        print("not gobbo or platform")
#    #$CollisionShape2D.disabled = true
#    if(hp<=0):
#        hide()
#        $CollisionShape2D.disabled = true
#        dead=1
##func overlaps_body(body):
##    if(body.get_name() == "platformChild"):
##        velocity.y -= GRAVITY
##    else:
##        print("not gobbo or platform")
##    $CollisionShape2D.disabled = true
    
func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false
    
    
