Vec2 = Crafty.math.Vector2D

Crafty.c "Centered", {
  get_pos: ()->
    return new Vec2(@x+@w/2,@y+@h/2)

  set_pos: (x, y) ->
    if not y?
      @x = x.x - @w/2
      @y = x.y - @h/2
    else
      @x = x - @w/2
      @y = y - @h/2
    return this
}
