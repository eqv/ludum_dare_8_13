Crafty.c "BackgroundObject",  {
  backgroundObject: (info) ->
    this.requires "2D, Canvas, Image"
    this.image(info.path)
    @base_pos = new Vec2(info.x, info.y)
    @x = info.x
    @y = info.y
    
    @alpha = info.alpha
    @depth = info.depth
    this.bind "EnterFrame", this.set_parallax

  set_parallax: () ->
    vx = Crafty.viewport.x
    vy = Crafty.viewport.y
    offset = (new Vec2(-vx, -vy)).scale(@depth).add(@base_pos)
    @x = offset.x
    @y = offset.y
}
