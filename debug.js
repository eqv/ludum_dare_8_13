var dbg_point, dbg_points_by_string, draw_line;

Crafty.c("DebugPoint", {
  init: function() {
    return this.requires("DOM,2D,Color,Mouse,Delay");
  }
});

dbg_points_by_string = {};

dbg_point = function(x, y, string) {
  var color, dot;
  color = "#" + (MD5(string).substr(0, 6));
  if (dbg_points_by_string[string]) {
    return dbg_points_by_string[string].attr({
      x: x,
      y: y
    });
  } else {
    dot = Crafty.e("DebugPoint").attr({
      x: x,
      y: y,
      w: 3,
      h: 3
    });
    dbg_points_by_string[string] = dot;
    return dot.color(color);
  }
};

draw_line = function(start, end, color) {
  var ctx;
  if (!(Crafty.canvas._canvas != null)) return;
  ctx = Crafty.canvas._canvas.getContext("2d");
  ctx.beginPath();
  ctx.moveTo(start.x, start.y);
  ctx.lineTo(end.x, end.y);
  ctx.strokeStyle = color != null ? color : "#FFFFFF";
  return ctx.stroke();
};
