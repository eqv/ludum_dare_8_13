Vec2 = Crafty.math.Vector2D

rot_at_frame = (frame, prev) ->
  if frame.end_rot?
    frame.end_rot
  else if frame.rot_center?
    a = prev.end_pos.clone().subtract(frame.rot_center.clone())
    b = frame.end_pos.clone().subtract(frame.rot_center.clone())
    prev.end_rot + Crafty.math.radToDeg a.angleBetween b
  else
    Crafty.math.radToDeg prev.end_pos.angleTo(frame.end_pos)

Crafty.c "AnimatedShip", {
  init: ->
    this.requires "2D"
    this.bind "EnterFrame", this.on_frame
    @start = Date.now()
    @start_frame =
      end_pos: new Vec2(@x, @y)
      end_time: 0
      end_rot: @rotation

    prev = @start_frame
    for frame in @keyframes
      frame.end_rot = rot_at_frame frame, prev
      prev = frame

  on_frame: () ->
    diff = (Date.now() - @start) / 1000
    current_frame = @start_frame
    next_frame = null
    for keyframe in @keyframes
      if keyframe.end_time < diff
        current_frame = keyframe
      else
        next_frame = keyframe
        break
    if next_frame?
      frameDuration = next_frame.end_time - current_frame.end_time
      progress = (diff - current_frame.end_time) / frameDuration
      @rotation = (1 - progress) * current_frame.end_rot + progress * next_frame.end_rot
      if next_frame.rot_center?
        a = current_frame.end_pos.clone().subtract(next_frame.rot_center)
        b = next_frame.end_pos.clone().subtract(next_frame.rot_center)
        angle = progress * b.angleBetween(a) + a.angleBetween(new Vec2(1, 0))
        vec = next_frame.rot_center.clone().add(new Vec2(Math.cos(angle), -Math.sin(angle)).scaleToMagnitude next_frame.radius)
        @x = vec.x
        @y = vec.y
      else
        @x = (1 - progress) * current_frame.end_pos.x + progress * next_frame.end_pos.x
        @y = (1 - progress) * current_frame.end_pos.y + progress * next_frame.end_pos.y
    else
      @rotation = current_frame.end_rot
      @x = current_frame.end_pos.x
      @y = current_frame.end_pos.y
}