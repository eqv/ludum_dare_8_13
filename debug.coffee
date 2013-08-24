Crafty.c "DebugPoint", {
  init: ->
    this.requires("DOM,2D,Color,Mouse,Delay")
}

dbg_points_by_string = {}
dbg_point =  (x,y,string) ->
  color = "##{MD5(string).substr(0,6)}"
  console.log(string, color, x,y)
  if dbg_points_by_string[string]
    dbg_points_by_string[string].attr(x: x, y:y)
  else
    dot = Crafty.e("DebugPoint").attr(x: x, y: y, w: 10, h: 10)
    dbg_points_by_string[string] = dot
    dot.color(color)
