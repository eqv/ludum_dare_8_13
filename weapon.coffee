Vec2 = Crafty.math.Vector2D

degToRad = (deg) ->
  return deg*Math.PI/180

Crafty.c "Weapon", {
  init: () ->
    this.requires "2D, Collision, Delay"
    @arc = 90
    @reload_time = 1
    @charge = @reload_time
    @speed = 5
    @shield_dmg = 10
    @armor_dmg = 10
    @duration = 5000
    @range = 300
    @color_head = "rgba(255, 255, 255, 1)"
    @color_tail = "rgba(255, 255, 255, 0)"
    @width = 1
    @ship = null
    @box = null
    @last_frame = Date.now()
    this.bind "EnterFrame", this.on_frame.bind(this)

  weapon: (ship) ->
    @ship = ship
    @ship.attach this
    @box = this.build_poly()
    this.collision @box

  build_poly: () ->
    pos1 = new Vec2 0, 0
    pos2 = (new Vec2 Math.cos(Crafty.math.degToRad(-@arc/2 + @rotation)),
                     Math.sin(Crafty.math.degToRad(-@arc/2 + @rotation))).scale(@range)
    pos3 = (new Vec2 Math.cos(Crafty.math.degToRad( @arc/2 + @rotation)),
                     Math.sin(Crafty.math.degToRad( @arc/2 + @rotation))).scale(@range)
    new Crafty.polygon pos1.asArray(), pos2.asArray(), pos3.asArray()

  build_bullet: (vx, vy) ->
    Crafty.e("Bullet").attr(
                             x: @x, y: @y, vx: vx, vy: vy,
                             width: @width, color_tail: @color_tail, color_head: @color_head,
                             duration: @duration, armor_dmg: @armor_dmg, shield_dmg: @shield_dmg
                           ).bullet(@ship.team)

  on_frame: () ->
    if window.currentLevel? and window.currentLevel.state == "animating"
      now = Date.now()
      @charge = Math.min @reload_time, @charge + now - @last_frame
      @last_frame = now
      if @charge >= @reload_time and @ship.is_alive()
        for ship in window.currentLevel.ships
          if ship.team == @ship.team or not ship.is_alive()
            continue
          sp = ship.get_pos()
          if @box.containsPoint sp.x, sp.y
            @charge = 0
            this.delay( () ->
              dir = sp.subtract(new Vec2 @x, @y).scaleToMagnitude(@speed)
              this.build_bullet(dir.x, dir.y)
            ,100*(@detection_delay||0), 0)
            return
}
