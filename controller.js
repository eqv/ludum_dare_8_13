
Crafty.c("RestrictedDraggable", {
  _origMouseDOMPos: null,
  _oldX: null,
  _oldY: null,
  _dragging: false,
  _dir: null,
  _ondrag: null,
  _ondown: null,
  _onup: null,
  init: function() {
    return this.requires("Mouse");
  },
  _ondrag: function(e) {
    var next_x, next_y, pos;
    pos = Crafty.DOM.translate(e.clientX, e.clientY);
    if (pos.x === 0 || pos.y === 0) return false;
    next_x = this._oldX + (pos.x - this._origMouseDOMPos.x);
    next_y = this._oldY + (pos.y - this._origMouseDOMPos.y);
		vec = this.is_valid_drag_position(x, y)) 
		console.log "foooo",vec
		this.x = vec.x;
		this.y = vec.y;
		return this.trigger("Dragging", e);
  },
  _ondown: function(e) {
    if (e.mouseButton !== Crafty.mouseButtons.LEFT) return;
    return this._startDrag(e);
  },
  _onup: function(e) {
    if (this._dragging === true) {
      Crafty.removeEvent(this, Crafty.stage.elem, "mousemove", this._ondrag);
      Crafty.removeEvent(this, Crafty.stage.elem, "mouseup", this._onup);
      this._dragging = false;
      this.trigger("StopDrag", e);
    }
    return this.enableDrag();
  },
  _startDrag: function(e) {
    this._origMouseDOMPos = Crafty.DOM.translate(e.clientX, e.clientY);
    this._oldX = this._x;
    this._oldY = this._y;
    this._dragging = true;
    Crafty.addEvent(this, Crafty.stage.elem, "mousemove", this._ondrag);
    Crafty.addEvent(this, Crafty.stage.elem, "mouseup", this._onup);
    return this.trigger("StartDrag", e);
  },
  stopDrag: function() {
    Crafty.removeEvent(this, Crafty.stage.elem, "mousemove", this._ondrag);
    Crafty.removeEvent(this, Crafty.stage.elem, "mouseup", this._onup);
    this._dragging = false;
    this.trigger("StopDrag");
    return this;
  },
  startDrag: function() {
    if (!this._dragging) this._startDrag(Crafty.lastEvent);
    return this;
  },
  enableDrag: function() {
    this.bind("MouseDown", this._ondown);
    Crafty.addEvent(this, Crafty.stage.elem, "mouseup", this._onup);
    return this;
  },
  disableDrag: function() {
    this.unbind("MouseDown", this._ondown);
    if (this._dragging) this.stopDrag();
    return this;
  }
});
