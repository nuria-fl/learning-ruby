class Scene
  def enter()
    puts "TODO"
    exit(1)
  end
end


class Engine

  def initialize(scene_map)
    @scene_map = scene_map
  end

  def play()
    current_scene = @scene_map.opening_scene
    last_scene = @scene_map.final_scene

    while current_scene != last_scene
      next_scene_name = current_scene.enter
      puts next_scene_name
      current_scene = @scene_map.next_scene(next_scene_name)
    end

    current_scene.enter
  end
end

class Death < Scene
  def enter()
    puts "You die"

    exit(0)
  end
end

class CentralCorridor < Scene

  def initialize()
    super()
  end

  def enter()
    puts "Aliens have invaded a space ship and our hero has to go through a maze of rooms defeating them so he can escape into an escape pod to the planet below."
    puts "Gothon appears > "

    action = $stdin.gets.chomp

    if action == "tell joke"
      puts "going to next scene"
      return :laser_weapon_armory
    elsif action == "shoot"
      puts "that didn't work"
      return :death
    else
      puts "do not understand"
      return :central_corridor
    end

  end
end

class LaserWeaponArmory < Scene
  def initialize()
    super()
  end
end

class TheBridge < Scene

  def enter()
  end
end

class EscapePod < Scene

  def enter()
  end
end


class Map
  @@scenes = {
    central_corridor: CentralCorridor.new(),
    laser_weapon_armory: LaserWeaponArmory.new(),
    the_bridge: TheBridge.new(),
    escape_pod: EscapePod.new(),
    death: Death.new()
    # finished: Finished.new()
  }

  attr_reader :final_scene

  def initialize(start_scene)
    @start_scene = start_scene
    @final_scene = :escape_pod
  end

  def next_scene(scene_name)
    @@scenes[scene_name]
  end

  def opening_scene()
    next_scene(@start_scene)
  end
end


a_map = Map.new(:central_corridor)
a_game = Engine.new(a_map)
a_game.play()