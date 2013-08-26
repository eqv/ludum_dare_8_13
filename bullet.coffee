bullet_last_update = 0

Crafty.c "Bullet", {
  init: () ->
    this.requires "2D, Collision"
    @width = 1
    @color_head = "rgba(255, 255, 255, 1)"
    @color_tail = "rgba(255, 255, 255, 0)"
    @armor_dmg = 1
    @shield_dmg = 1
    @duration = 1000

    @now = @start_time = Date.now()
    @animating = true
    @my_team = null

    @c = $("#bullet_canvas")[0]
    if not @c?
      @c = document.createElement "canvas"
      @c.id = "bullet_canvas"
      @c.width = Crafty.viewport.width
      @c.height = Crafty.viewport.height
      @c.style.position = "absolute"
      @c.style.left = "0px"
      @c.style.top = "0px"
      Crafty.stage.elem.appendChild @c
    @ctx = @c.getContext "2d"
    this.bind "EnterFrame", this.on_frame
    this.collision new Crafty.polygon [0, 0]
    this.onHit "Damagable", this.on_hit

  bullet: (my_team) ->
    @start_pos = new Vec2 @x, @y
    @my_team = my_team

  stop: () ->
    if @animating
      @animating = false
      @now = Date.now()
      @duration -= @now - @start_time

  start: () ->
    if not @animating
      @animating = true
      @start_time = Date.now()

  on_frame: (e) ->
    if bullet_last_update < e.frame
      bullet_last_update = e.frame
      @ctx.setTransform 1, 0, 0, 1, 0, 0
      @ctx.clearRect 0, 0, @c.width, @c.height
      @ctx.setTransform 1, 0, 0, 1, Crafty.viewport.x, Crafty.viewport.y

    if currentLevel.state == "planning"
      this.stop()
    else if currentLevel.state == "animating"
      this.start()

    @now = if @animating then Date.now() else @now
    if @now - @start_time < @duration
      if @animating
        @x += @vx
        @y += @vy
      len = @start_pos.distance new Vec2(@x, @y)
      if len > 80
        @start_pos.scale(80/len).add new Vec2(@x, @y).scale(1 - 80/len)
      trail_mid = Math.max 0, 1 - 15/len
      @ctx.beginPath()
      lingrad = @ctx.createLinearGradient @start_pos.x, @start_pos.y, @x, @y
      lingrad.addColorStop 0, @color_tail
      lingrad.addColorStop trail_mid, @color_head
      lingrad.addColorStop 1, @color_head
      @ctx.strokeStyle = lingrad
      @ctx.lineCap = "round"
      @ctx.lineWidth = @width
      @ctx.moveTo(@start_pos.x, @start_pos.y)
      @ctx.lineTo(@x, @y)
      @ctx.stroke()
    else if @animating
      this.destroy()

  on_hit: (e) ->
    return if @duration <= 0
    for s in e
      if s.obj.team != @my_team
        @duration = 0
        s.obj.take_dmg(this)
        this.unbind("Hit",this.on_hit)
    
}
