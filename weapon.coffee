Crafty.c "Weapon", {
  init: () ->
    this.requires "2D, Collision"
    @ox = 0
    @oy = 0
    @rot = 0
    @arc = 90
    @reload_time = 1
    @ship = null
    @poly = null

  weapon: (ox, oy, rot, arc, reload_time, ship) ->
    @ox = ox
    @oy = oy
    @rot = rot
    @arc = arc
    @reload_time = reload_time
    @ship = ship
    @poly = this.build_poly()
    this.collision @poly
    this.onHit "Ship", this.on_hit.bind this
    ship.bind "Move", this.on_move.bind this
    ship.bind "Rotate", this.on_rotate.bind this

  build_poly: () ->
    pos1 = new Vec2(@ship.x + @ox, @ship.y + @oy)
    pos2 = (new Vec2 Math.cos(Crafty.math.degToRad -@arc/2), Math.sin(Crafty.math.degToRad -@arc/2)).scale(10000).add(pos1)
    pos3 = (new Vec2 Math.cos(Crafty.math.degToRad  @arc/2), Math.sin(Crafty.math.degToRad  @arc/2)).scale(10000).add(pos1)
    matrix = new Crafty.math.Matrix2D().rotate(@ship.rotation + @rot)
    matrix.apply(p) for p in [pos1, pos2, pos3]
    new Crafty.polygon pos1.asArray(), pos2.asArray(), pos3.asArray()

  on_move: (e) ->
    @x = @ship.get_pos().x
    @y = @ship.get_pos().y

  on_rotate: (e) ->
    if e? and e.deg?
      @rotation = @ship.rotation - e.deg

  on_hit: (hit) ->
    #console.log hit
 } 
