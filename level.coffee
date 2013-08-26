levels = []
currentLevel = null

levels[1] =
  name: "Training",
  deco: [
    { path: "assets/iris.png", x: -100, y: -100, alpha: 1, depth: 0.99 }
    { path: "assets/planet.png", x: 100, y: 100, alpha: 1, depth: 0.5 }
    { path: 'assets/tutorial/next_round.png', x: 20,  y: 80,  alpha: 1, depth: 0.1 }
    { path: 'assets/tutorial/ships.png',      x: 100, y: 20,  alpha: 1, depth: 0.1 },
    { path: 'assets/tutorial/ship.png',       x: 100, y: 300, alpha: 1, depth: 0.1 }
    { path: 'assets/tutorial/camera.png',     x: 600, y: 100, alpha: 1, depth: 0.1 }
    { path: 'assets/tutorial/controller.png', x: 370, y: 280, alpha: 1, depth: 0.1 }
    { path: 'assets/tutorial/enemy.png',      x: 500, y: 400, alpha: 1, depth: 0.1 }
  ],
  ships: [
    { type: "Cruiser", x: 300, y: 350, rot:   0, team: "Player 1"},
    { type: "Fighter", x: 700, y: 350, rot: 180, team: "Player 2"},
  ],
  teams: [
    { name: "Player 1", type: "HumanPlayer" },
    { name: "Player 2", type: "SittingDuckAI" }
  ]

levels[2] =
  name: "Fun with Fighters",
  deco: [
    { path: "assets/iris.png", x: -100, y: -100, alpha: 1, depth: 0.99 }
  ],
  ships: [
    { type: "Fighter", x: 250, y: 100, rot:   0, team: "Player 1"},
    { type: "Fighter", x: 250, y: 160, rot:   0, team: "Player 1"},
    { type: "Fighter", x: 250, y: 220, rot:   0, team: "Player 1"},
    { type: "Fighter", x: 250, y: 280, rot:   0, team: "Player 1"},
    { type: "Fighter", x: 800, y: 100, rot: 180, team: "Player 2"},
    { type: "Fighter", x: 800, y: 160, rot: 180, team: "Player 2"},
    { type: "Fighter", x: 800, y: 220, rot: 180, team: "Player 2"},
    { type: "Fighter", x: 800, y: 280, rot: 180, team: "Player 2"},
  ],
  teams: [
    { name: "Player 1", type: "HumanPlayer" },
    { name: "Player 2", type: "HumanPlayer" }
  ]

levels[3] =
  name: "The Ambush"
  deco: [
    { path: "assets/iris.png", x: -100, y: -100, alpha: 1, depth: 0.99 }
  ],
  ships: [
    { type: "Fighter", x: 650, y: 100, rot: 150, team: "Player 1"},
    { type: "Fighter", x: 675, y: 150, rot: 150, team: "Player 1"},
    { type: "Fighter", x: 700, y: 200, rot: 150, team: "Player 1"},
    { type: "Fighter", x: 700, y: 350, rot: 180, team: "Player 1"},
    { type: "Fighter", x: 700, y: 500, rot: 210, team: "Player 1"},
    { type: "Fighter", x: 675, y: 550, rot: 210, team: "Player 1"},
    { type: "Fighter", x: 650, y: 600, rot: 210, team: "Player 1"},
    { type: "Cruiser", x: 300, y: 350, rot: 180, team: "Player 2"},
    { type: "Cruiser", x: 300, y: 400, rot: 180, team: "Player 2"},
  ],
  teams: [
    { name: "Player 1", type: "HumanPlayer" },
    { name: "Player 2", type: "HumanPlayer" }
  ]

levels[4] =
  name: "Epic Fleet Fight"
  deco: [
    { path: "assets/iris.png", x: -100, y: -100, alpha: 1, depth: 0.99 }
  ],
  ships: [
    { type:    "Fighter", x: 200, y: 175, rot:   0, team: "Player 1" },
    { type:    "Fighter", x: 200, y: 225, rot:   0, team: "Player 1" },
    { type:    "Cruiser", x: 100, y: 275, rot:   0, team: "Player 1" },
    { type: "BattleShip", x: 100, y: 350, rot:   0, team: "Player 1" },
    { type:    "Cruiser", x: 100, y: 425, rot:   0, team: "Player 1" },
    { type:    "Fighter", x: 200, y: 475, rot:   0, team: "Player 1" },
    { type:    "Fighter", x: 200, y: 525, rot:   0, team: "Player 1" },

    { type:    "Fighter", x: 800, y: 175, rot: 180, team: "Player 2" },
    { type:    "Fighter", x: 800, y: 225, rot: 180, team: "Player 2" },
    { type:    "Cruiser", x: 900, y: 275, rot: 180, team: "Player 2" },
    { type: "BattleShip", x: 900, y: 350, rot: 180, team: "Player 2" },
    { type:    "Cruiser", x: 900, y: 425, rot: 180, team: "Player 2" },
    { type:    "Fighter", x: 800, y: 475, rot: 180, team: "Player 2" },
    { type:    "Fighter", x: 800, y: 525, rot: 180, team: "Player 2" },
  ],
  teams: [
    { name: "Player 1", type: "HumanPlayer" },
    { name: "Player 2", type: "HumanPlayer" }
  ]

class Level
  constructor: (lvl) ->
    @ships = []
    @teams = []
    @teams_by_name = {}
    Crafty.background("#000000")
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
      team = @teams[@current_team]
      @current_team+=1
      team.planning_turn()

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
        window.winner = team
    if alive_teams <= 0
      window.winner = { name: "Nobody" }
    if alive_teams <= 1
      Crafty.scene("menu")
      clear_bullet_canvas()
      return true
    return false

  get_living_ships_of: (team) ->
    return (ship for ship in team.fleet when ship.is_alive())

startScene = (i) ->
  currentLevel = new Level levels[i]
  Crafty.viewport.mouselook(true)
  currentLevel.planning_phase()

Crafty.scene("level_" + i, startScene.bind(null, i)) for i in [1..levels.length-1]
