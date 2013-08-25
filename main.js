
$(document).ready(function() {
  Crafty.init(640, 480);
  Crafty.canvas.init();
  Crafty.scene("menu");
  return Crafty.viewport.clampToEntities = false;
});
