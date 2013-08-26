levels = []
currentLevel = null

levels[1] =
  deco: [
    { 
      path: "assets/iris.png"
      x: -100
      y: -100
      alpha: 1
      depth: 0.9
    },
    { 
      path: "assets/planet.png"
      x: 100
      y: 100
      alpha: 1
      depth: 0.5
    }
  ],
  ships: [
    {
      type: "BattleShip"
      x: 320
      y: 240
      rot: 20
      team: "coco"
    },
    {
      type: "Cruiser"
      x: 150
      y: 100
      rot: 90
      team: "eugen"
    },
    {
      type: "Fighter"
      x: 100
      y: 120
      rot: 30
      team: "eugen"
    }
  ],
  teams: [
    {
      name: "eugen"
      type: "HumanPlayer"
    },
    {
      name: "coco"
      type: "HumanPlayer"
    }
  ]

class Level
  constructor: (lvl) ->
    @ships = []
    @teams = []
    @teams_by_name = {}
    for bckg_info,i in lvl.deco
      Crafty.e("BackgroundObject").backgroundObject( bckg_info)
    for team_desc,i in lvl.teams
        team = Crafty.e(team_desc.type)
        team.name = team_desc.name
        @teams[i] = team
        @teams_by_name[team_desc.name] = team
    for ship_desc,i in lvl.ships
      ship = Crafty.e(ship_desc.type)
      ship.ship()
      ship.attr(rotation: ship_desc.rot)
      ship.set_pos(ship_desc.x, ship_desc.y)
      ship.team = ship_desc.team
      ship.ship_id = @teams_by_name[ship_desc.team].fleet.length
      @teams_by_name[ship_desc.team].fleet.push(ship)
      @ships[i] = ship

  next_planning_turn: () ->
    if @current_team >= @teams.length
      this.animation_phase()
    else
      @teams[@current_team].planning_turn()
      @current_team+=1

  planning_phase: () ->
    this.check_win_conditions()
    @state = "planning"
    for obj_id in Crafty("Damagable")
      Crafty(obj_id).regen_shields()
    return if this.check_win_conditions()
    for ship in Crafty("Ship")
      ship = Crafty(ship)
      ship.removeComponent("AnimatedShip")
    @current_team = 0
    this.next_planning_turn()

  animation_phase: () ->
    @state = "animating"
    for ship_id in Crafty("Ship")
      ship = Crafty(ship_id)
      ship.addComponent("AnimatedShip")

  ship_finished_animating: () ->
    count_unfinished_ships = 0
    for ship in Crafty("Ship")
      ship = Crafty(ship)
      count_unfinished_ships += 1 if ship.has("AnimatedShip")
    this.planning_phase() if count_unfinished_ships == 0

  check_win_conditions: () ->
    alive_teams = 0
    for team in @teams
      if this.get_living_ships_of(team).length > 0
        alive_teams += 1
    if alive_teams <= 1
      console.log "We have a Winner, going to game_ended scene"
      Crafty.scene("game_ended")
      return true
    return false

  get_living_ships_of: (team) ->
    return (ship for ship in team.fleet when ship.is_alive())

startScene = (i) ->
  currentLevel = new Level levels[i]
  Crafty.viewport.mouselook(true)
  currentLevel.planning_phase()

Crafty.scene("level_" + i, startScene.bind(null, i)) for i in [1..5]
