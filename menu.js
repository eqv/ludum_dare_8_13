var buildButton, load_level;

buildButton = function(label, pos, click_handler) {
  var entity;
  entity = Crafty.e("2D, Canvas, Mouse, Text").attr({
    x: 280,
    y: 150 + pos * 25,
    h: 20
  });
  entity.text(label).textColor("#FFFFFF").textFont({
    family: "Helvetica",
    size: "20px"
  });
  return entity.bind("Click", click_handler);
};

load_level = function(lvl) {
  return Crafty.scene("level_" + lvl);
};

Crafty.scene("menu", function() {
  var i, _results;
  Crafty.background("#444");
  Crafty.viewport.mouselook(false);
  _results = [];
  for (i = 1; i <= 5; i++) {
    _results.push(buildButton("Level " + i, i - 1, load_level.bind(null, i)));
  }
  return _results;
});
