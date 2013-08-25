Crafty.c "Weapon", {
  init: () ->
    this.requires "2D"
    @arc = 90
    @reload_time = 1
    @charge = 1
    @speed = 3
    @dmg = 1
    @duration = 5000
    @range = 300
    @ship = null
    @box = null
    @last_frame = Date.now()
    this.bind "EnterFrame", this.on_frame.bind this

  weapon: (arc, reload_time, ship) ->
    @arc = arc
    @reload_time = reload_time
    @charge = @reload_time
    @ship = ship
    @ship.attach this
    @box = this.build_poly()
    this.collision @box

  build_poly: () ->
    pos1 = new Vec2 @x, @y
    pos2 = (new Vec2 Math.cos(Crafty.math.degToRad -@arc/2), Math.sin(Crafty.math.degToRad -@arc/2)).scale(@range).add(pos1)
    pos3 = (new Vec2 Math.cos(Crafty.math.degToRad  @arc/2), Math.sin(Crafty.math.degToRad  @arc/2)).scale(@range).add(pos1)
    new Crafty.polygon pos1.asArray(), pos2.asArray(), pos3.asArray()

  on_frame: () ->
    if currentLevel.state == "animating"
      now = Date.now()
      @charge = Math.min @reload_time, @charge + now - @last_frame
      @last_frame = now
      if @charge >= @reload_time
        for ship in currentLevel.ships
          if ship.team == @ship.team
            continue
          if @box.containsPoint ship.x, ship.y
            @charge = 0
            dir = new Vec2(ship.x, ship.y).subtract(new Vec2 @x, @y).scaleToMagnitude(@speed)
            Crafty.e("Bullet").attr(x: @x, y: @y, vx: dir.x, vy: dir.y).bullet(@duration, @dmg, @ship.team)

 } 
