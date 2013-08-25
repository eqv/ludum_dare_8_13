
Crafty.c "ViewportStatic",{
  xOff : 0
  yOff : 0
  startGui : () ->
    this.requires("2D");
    this.bind "EnterFrame", ->
      relative_x = -Crafty.viewport.x + @xOff;
      relative_y = -Crafty.viewport.y + @yOff;
      if @_x !=  relative_x or @_y != relative_y
        @x = relative_x
        @y = relative_y
  }

Crafty.c "NextTurnButton", {
  init: () ->
    this.requires("2D, DOM, Image, Mouse, ViewportStatic")
    this.image("assets/next_turn.png")
    @xOff = 20
    @yOff = 20

  nextTurnButton: (team)->
    @team = team
    this.bind "Click" , this.on_click
    this.startGui()

  remove: ->
    this.destroy()

  on_click: (e) ->
    count_unused_ships = 0
    for ship_id in Crafty("ControllableShip")
      count_unused_ships += 1 if !Crafty(ship_id).controller.active
    ok = true
    if count_unused_ships > 0
      ok = confirm("you have unused ships, do you really want to continue?")
    if ok
      @team.cleanup_planning()
      currentLevel.next_planning_turn()
  }

Crafty.c "StatusBar", {
  init: () ->
    this.requires("2D, DOM, ViewportStatic, Color")
  statusBar: (icon,attr) ->
    @xOff = icon.xOff + (attr.xOff || 0)
    @yOff = icon.yOff + (attr.yOff || 0)
    @h = attr.h || 2
    @w = attr.factor*32 || 32
    this.color(attr.color || "#f00")
    this.startGui()
}

Crafty.c "ShipIcon", {

  init: () ->
    this.requires("2D, DOM, Image, Mouse, ViewportStatic")
    this.bind "Click" , this.on_click

  shipIcon: (ship) ->
    @ship = ship
    @xOff = 60 + ship.ship_id*36
    @yOff = 20
    this.startGui()
    this.set_icon(this, ship)
    @body = Crafty.e("StatusBar")
    armor_factor  = ship.get_armor_factor()
    shield_factor = ship.get_shield_factor()
    @body.statusBar(this, color: "#f00", factor: armor_factor, yOff: 32)
    @shield = Crafty.e("StatusBar")
    @shield.statusBar(this, color: "#00f", factor: shield_factor, yOff: 34 )
    that = this
    @set_icon_callback = () ->
      that.set_icon(that,ship)
    @ship.bind("SelectedShip", @set_icon_callback)
    @ship.bind("DeselectedShip", @set_icon_callback)

  remove: ->
    @ship.unbind("SelectedShip", @set_icon_callback)
    @ship.unbind("DeselectedShip",@set_icon_callback)
    @shield.destroy()
    @body.destroy()
    this.destroy()

  set_icon: (icon, ship)->
    if ship.armor_stat > 0
      if ship.controller? and ship.controller.selected
        icon.image("#{ship.filename}_icon_selected.png")
      else
        icon.image("#{ship.filename}_icon.png")
    else
      icon.image("#{ship.filename}_icon_dead.png")


  on_click: ->
    w = Crafty.viewport.width
    h = Crafty.viewport.height
    Crafty.viewport.x = -(@ship.get_pos().x-w/2)
    Crafty.viewport.y = -(@ship.get_pos().y-h/2)
    @ship.controller.activate()
  }
