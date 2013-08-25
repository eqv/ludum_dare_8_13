bullet_last_update = 0

Crafty.c "Bullet", {
  init: () ->
    this.requires "2D, Collision"
    @now = @start_time = Date.now()
    @animating = true
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
    this.bind "EnterFrame", this.on_frame.bind this
    this.collision new Crafty.polygon [0, 0]
    this.onHit "Ship", this.on_hit.bind this

  bullet: (duration, dmg, my_team) ->
    @duration = duration
    @dmg = dmg
    @my_team = my_team
    @start_pos = new Vec2 @x, @y

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
      lingrad.addColorStop 0, "rgba(255, 255, 255, 0)"
      lingrad.addColorStop trail_mid, "#FFFFFF"
      lingrad.addColorStop 1, "#FFFFFF"
      @ctx.strokeStyle = lingrad
      @ctx.moveTo(@start_pos.x, @start_pos.y)
      @ctx.lineTo(@x, @y)
      @ctx.stroke()
    else if @animating
      this.destroy()

  on_hit: (e) ->
    for s in e
      if s.obj.team != @my_team
        @duration = 0
        s.obj.destroy()
}
