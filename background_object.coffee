Crafty.c "BackgroundObject",  {
  backgroundObject: (info) ->
    this.requires "2D, Canvas, Image"
    this.image(info.path)
    @base_pos = new Vec2(info.x, info.y)
    @x = info.x
    @y = info.y
    
    @alpha = info.alpha
    @depth = info.depth
    Crafty.bind "ViewPortChanged", this.set_parallax.bind(this)

  set_parallax: () ->
    vx = Crafty.viewport.x
    vy = Crafty.viewport.y
    offset = (new Vec2(-vx, -vy)).scale(@depth).add(@base_pos)
    @x = offset.x
    @y = offset.y
}
