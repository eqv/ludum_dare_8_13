#
# #Draggable
# @category Input
# Enable drag and drop of the entity.
# @trigger Dragging - is triggered each frame the entity is being dragged - MouseEvent
# @trigger StartDrag - is triggered when dragging begins - MouseEvent
# @trigger StopDrag - is triggered when dragging ends - MouseEvent
#
Crafty.c "RestrictedDraggable", {
  _origMouseDOMPos: null
  _oldX: null
  _oldY: null
  _dragging: false
  _dir:null

#Note: the code is note tested with zoom, etc., that may distort the direction between the viewport and the coordinate on the canvas.
  init: ->
    this.requires "Mouse"

  _ondrag: (e) ->
      pos = Crafty.DOM.translate(e.clientX, e.clientY);
      # ignore invalid 0 0 position - strange problem on ipad
      if (pos.x == 0 || pos.y == 0)
        return false;
      next_x = this._oldX + (pos.x - this._origMouseDOMPos.x);
      next_y = this._oldY + (pos.y - this._origMouseDOMPos.y);
      vec = this.is_valid_drag_position(next_x,next_y)
      if vec
        this.x = vec.x
        this.y = vec.y
        this.trigger("Dragging", e);

  _ondown: (e) ->
    if (e.mouseButton != Crafty.mouseButtons.LEFT)
      return
    this._startDrag(e);

  _onup: (e) ->
    if (this._dragging == true)
      Crafty.removeEvent(this, Crafty.stage.elem, "mousemove", this._ondrag);
      Crafty.removeEvent(this, Crafty.stage.elem, "mouseup", this._onup);
      this._dragging = false;
      this.trigger("StopDrag", e);
    this.enableDrag();

  #**@
  # #._startDrag
  # @comp Draggable
  # Internal method for starting a drag of an entity either programatically or via Mouse click
  #
  # @param e - a mouse event
  #/
  _startDrag: (e) ->
    this._origMouseDOMPos = Crafty.DOM.translate(e.clientX, e.clientY);
    this._oldX = this._x;
    this._oldY = this._y;
    this._dragging = true;

    Crafty.addEvent(this, Crafty.stage.elem, "mousemove", this._ondrag);
    Crafty.addEvent(this, Crafty.stage.elem, "mouseup", this._onup);
    this.trigger("StartDrag", e);

  #**@
  # #.stopDrag
  # @comp Draggable
  # @sign public this .stopDrag(void)
  # @trigger StopDrag - Called right after the mouse listeners are removed
  #
  # Stop the entity from dragging. Essentially reproducing the drop.
  #
  # @see .startDrag
  #/
  stopDrag: ->
    Crafty.removeEvent(this, Crafty.stage.elem, "mousemove", this._ondrag);
    Crafty.removeEvent(this, Crafty.stage.elem, "mouseup", this._onup);

    this._dragging = false;
    this.trigger("StopDrag");
    return this;

  #**@
  # #.startDrag
  # @comp Draggable
  # @sign public this .startDrag(void)
  #
  # Make the entity follow the mouse positions.
  #
  # @see .stopDrag
  #/
  startDrag: ->
    if (!this._dragging)
      #Use the last known position of the mouse
      this._startDrag(Crafty.lastEvent);
    return this

  #**@
  # #.enableDrag
  # @comp Draggable
  # @sign public this .enableDrag(void)
  #
  # Rebind the mouse events. Use if `.disableDrag` has been called.
  #
  # @see .disableDrag
  #/
  enableDrag: ->
    this.bind("MouseDown", this._ondown);
    Crafty.addEvent(this, Crafty.stage.elem, "mouseup", this._onup);
    return this;

  #**@
  # #.disableDrag
  # @comp Draggable
  # @sign public this .disableDrag(void)
  #
  # Stops entity from being draggable. Reenable with `.enableDrag()`.
  #
  # @see .enableDrag
  #/
  disableDrag: ->
    this.unbind("MouseDown", this._ondown)
    if (this._dragging)
      this.stopDrag()
    return this
}
