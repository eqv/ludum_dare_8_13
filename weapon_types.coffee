Crafty.c "StandardWeapon", {
  init: ->
    this.requires "Weapon"
    @arc = 90
    @reload_time = 2000
    @charge = @reload_time
    @speed = 5
    @shield_dmg = 1
    @armor_dmg = 1
    @duration = 5000
    @range = 300
    @color_head = "rgba(0, 0, 255, 1)"
    @color_tail = "rgba(255, 0, 0, 0)"
    @width = 3
}
