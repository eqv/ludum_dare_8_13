Crafty.c "Ship", {
  init: ->
    this.requires "2D,DOM,Image"
    this.bind "Change", () -> this.origin("center");

  get_dir: ()->
    return (new Vec2(1,0)).rotate(@_rotation)

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

  get_path_to: (target) ->
    steering = this.get_steering_circle(target)
    center = steering.center
    radius = steering.radius

    if this.is_valid_target(target, center, radius)
      return end_pos: target, center: center, radius: radius, end_time: 1
    else
      this.get_closest_valid_target(target, center,radius)
      dbg_point(target.x, target.y,"target")
      dbg_point(center.x, center.y, "center")
      return null

  get_closest_valid_target: (target, center, radius) ->
    dist = this.get_movement_length(target, center, radius)
    if !center
      console.log("no center")
      if dist > this.max_move_dist() 
        new_target = this.get_pos().subtract(target).normalize().scale(this.max_move_dist())
        new_target.add this.get_pos()
        target.x = new_target.x
        target.y = new_target.y
      if dist < this.min_move_dist() 
        new_target = this.get_pos().subtract(target).normalize().scale(this.min_move_dist())
        new_target.add this.get_pos()
        target.x = new_target.x
        target.y = new_target.y
    else
      if radius < this.min_turning_radius()
        console.log("rad is of")
        new_center = target.clone().subtract(this.get_pos()).normalize().scale(this.min_turning_radius())
        new_center.add this.get_pos()
        center.x = new_center.x
        center.y = new_center.y
        radius = this.min_turning_radius
        dist = this.get_movement_length(target, center, radius)
      if dist < this.min_move_dist() 
        console.log("to small")
        target_dir = target.clone().subtract(center)
        self_dir = this.get_pos().subtract(center)
        radians_of = (this.min_move_dist()-dist)/radius
        new_target_a = target_dir.clone().rotate(radians_of)
        new_target_b = target_dir.clone().rotate(-radians_of)
        if self_dir.angleTo(new_target_a) < self_dir.angleTo(new_target_b)
          target.x = new_target_b.x + center.x
          target.y = new_target_b.y + center.y
        else
          target.x = new_target_b.x + center.x
          target.y = new_target_b.y + center.y
      if dist > this.max_move_dist() 
        console.log("to big")
        target_dir = target.clone().subtract(center)
        self_dir = this.get_pos().subtract(center)
        radians_of = (this.min_move_dist()-dist)/radius
        console.log "correcting #{radians_of}"
        new_target_a = target_dir.clone().rotate(radians_of)
        new_target_b = target_dir.clone().rotate(-radians_of)

        dbg_point(center.x+new_target_a.x, center.y+new_target_a.y, "target a")
        dbg_point(center.x+new_target_b.x, center.y+new_target_b.y, "target b")
        if self_dir.angleTo(new_target_a) > self_dir.angleTo(new_target_b)
          target.x = new_target_b.x + center.x
          target.y = new_target_b.y + center.y
        else
          target.x = new_target_b.x + center.x
          target.y = new_target_b.y + center.y

  is_valid_target: (target, center, radius) ->
    dist = this.get_movement_length(target, center, radius)
    return false if dist > this.max_move_dist() || dist < this.min_move_dist()
    return false if center && radius < this.min_turning_radius()
    return true

  min_turning_radius: ->
    return 100
  max_move_dist: ->
    return 100
  min_move_dist: ->
    return 50

  get_movement_length: (target, center, radius) -> 
    if center
      rad = (this.get_pos().subtract(center)).angleTo(target.clone().subtract(center))
      return Math.abs(rad*radius)
    else
      return this.get_pos().subtract(target).magnitude()


  get_steering_circle: (target)->
    pos = this.get_pos()
    dir = this.get_dir()
    in_dir = pos.clone().add(dir.clone().scale(20))
    target_dir = target.clone().subtract(pos).normalize()
    l1_p1 = pos
    l1_p2 = dir.rotate_90().add(pos)

    halfway = pos.clone().add(target).scale(0.5)
    l2_p1 = halfway
    l2_p2 = target_dir.rotate_90().scale(10).add(halfway)
    center = this.checkLineIntersection(l1_p1,l1_p2,  l2_p1,l2_p2)
    return center: center, radius: center and center.distance(pos) 


  checkLineIntersection: (line1_start,line1_end, line2_start, line2_end) ->
    denominator = ((line2_end.y - line2_start.y) * (line1_end.x - line1_start.x)) - 
        ((line2_end.x - line2_start.x) * (line1_end.y - line1_start.y))
    if denominator == 0
        return null
    a = line1_start.y - line2_start.y;
    b = line1_start.x - line2_start.x;
    numerator1 = ((line2_end.x - line2_start.x) * a) - ((line2_end.y - line2_start.y) * b);
    numerator2 = ((line1_end.x - line1_start.x) * a) - ((line1_end.y - line1_start.y) * b);
    a = numerator1 / denominator;
    b = numerator2 / denominator;

    #/ if we cast these lines infinitely in both directions, they intersect here:
    x = line1_start.x + (a * (line1_end.x - line1_start.x));
    y = line1_start.y + (a * (line1_end.y - line1_start.y));
    return new Vec2(x,y)
  }



