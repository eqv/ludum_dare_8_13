Crafty.c "Ship", {
  init: ->
    this.requires "2D,DOM,Image"
    this.origin("center")

  get_dir: ()->
    rot_mat = new Crafty.math.Matrix2D().rotate(@_rotation)
    return rot_mat.apply(new Vec2(1,0))
  get_pos: ()->
    return new Vec2(@x,@y)

  get_path_to: (target) ->
    steering = this.get_steering_circle(target)
    center = steering.center
    radius = steering.radius
    dist = this.get_movement_length(target, center, radius)

    return null if dist > this.max_move_dist() || dist < this.min_move_dist()
    return end_pos: target, center: center, radius: radius, end_time: 1, dist: dist

  max_move_dist: ->
    return 100

  min_move_dist: ->
    return 0

  get_movement_length: (target, center, radius) ->
    if center
      rad = (this.get_pos().subtract(center)).angleTo(target.clone().subtract(center))
      return rad*length
    else
      return this.get_pos().subtract(target).length()


  get_steering_circle: (target)->
    pos = new Vec2(@x, @y)
    dir = this.get_dir()
    target_dir = target.clone().subtract(pos)
    l1_p1 = pos
    l1_p2 = dir.rotate_90()

    halfway = pos.clone().add(target).scale(0.5)
    l2_p1 = halfway
    l2_p2 = target.rotate_90()
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



