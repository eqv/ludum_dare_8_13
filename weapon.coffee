Crafty.c "Weapon", {
  init: () ->
    this.requires "2D, Collision"
    @arc = 90
    @reload_time = 1
    @ship = null
    @poly = null

  weapon: (arc, reload_time, ship) ->
    @arc = arc
    @reload_time = reload_time
    @ship = ship
    @poly = this.build_poly()
    this.collision @poly
    this.onHit "Ship", this.on_hit.bind this
    @ship.attach this

  build_poly: () ->
    pos1 = new Vec2 @x, @y
    pos2 = (new Vec2 Math.cos(Crafty.math.degToRad -@arc/2), Math.sin(Crafty.math.degToRad -@arc/2)).scale(10000).add(pos1)
    pos3 = (new Vec2 Math.cos(Crafty.math.degToRad  @arc/2), Math.sin(Crafty.math.degToRad  @arc/2)).scale(10000).add(pos1)
    new Crafty.polygon pos1.asArray(), pos2.asArray(), pos3.asArray()

  on_hit: (hit) ->
    #console.log hit
 } 
