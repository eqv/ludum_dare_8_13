Crafty.c "DebugPoint", {
  init: ->
    this.requires("DOM,2D,Color,Mouse")
    this.timeout(this.destroy, 10000, 0)
    this.bind "Click", ->
      this.destroy()

}

point =  (x,y,string) ->
  Crafty.e("DebugPoint").attr x: x, y: y, text: string
