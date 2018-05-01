extends KinematicBody2D

signal hit
export (int) var SPEED # unused exported variable

var screensize
const GRAVITY = 125
var velocity = Vector2() # the player's movement vector

var on_air_time = 0
var jumping = false
var prev_jump_pressed = false

var stat = Hpmp.new()
var dead = false
var hp = 100
var mp = 100

const ATTACK_CD = 2 #attack once per 2 second
var cd_timer = 0

export (PackedScene) var projectile_scene

export (NodePath) var fireball_spawn_path
onready var fireball_spawn = get_node(fireball_spawn_path)

export (float) var fireball_angle = 350 setget set_fireball_angle
export (int) var fireball_speed = 8
export (int) var fireball_gravity = 5
var directional_force = Vector2()

func set_fireball_angle(value):
    fireball_angle = clamp(value, 0, 359)
    
func update_directional_force():
    # normalized vector
    # for fireball direction
    if velocity.x >= 0:
        directional_force = Vector2(cos(fireball_angle*PI/180), sin(fireball_angle*PI/180)) * fireball_speed
    else:
        directional_force = Vector2(-1*cos(fireball_angle*PI/180), sin(fireball_angle*PI/180)) * fireball_speed

const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 2000
const JUMP_MAX_AIRBORNE_TIME = 0.2
const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

func _ready():
    screensize = get_viewport_rect().size
        
func _process(delta):
    if not dead:
        var force = Vector2(0, GRAVITY)

        var new = Phys.new()
        var grav_y = new.grav(velocity.y, delta, GRAVITY)
        velocity.y = grav_y

        var move_left = Input.is_action_pressed("ui_left")
        var move_right = Input.is_action_pressed("ui_right")
        var jump = Input.is_action_pressed("ui_up")

        var attack = Input.is_action_pressed("ui_a")
        if cd_timer < ATTACK_CD:
            attack = false
        cd_timer += delta

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
        velocity = move_and_slide(velocity, Vector2(0, -1))
        if is_on_floor():
            on_air_time = 0
        if jumping and velocity.y > 0:
            # If falling, no longer jumping
            jumping = false

        if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
            # Jump must also be allowed to happen if the character left the floor a little bit ago.
            velocity.y = -JUMP_SPEED
            jumping = true
    
        on_air_time += delta
        prev_jump_pressed = jump

        if velocity.length() > 0:
           $AnimatedSprite.play()
        else:
            $AnimatedSprite.stop()

        position.x = clamp(position.x, 0, 3000)
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
        if attack:
            cd_timer = 0
            shoot()
            $AnimatedSprite.animation = "attack"    
            $AnimatedSprite.flip_h = velocity.x < 0
        
        update_directional_force()
        
        if move_left:       
            fireball_spawn.position.x = position.x - 25
        elif move_right:                                           
            fireball_spawn.position.x = position.x + 25
        else:
            fireball_spawn.position.x = position.x
        # ensures the fireball will spawn from the player's position
        fireball_spawn.position.y = position.y
    
func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false

func shoot():
    var fireball = projectile_scene.instance()
    fireball.set_pos(fireball_spawn.position)
    fireball.shoot(directional_force, fireball_gravity)
    get_parent().get_parent().add_child(fireball)
    
    
