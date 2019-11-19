# -----------
# Just my ruby version of mars rover challange
# It's my first time with ruby.
# -----------
# This file is, basically, the ruby version of this:
# https://github.com/danielbonifacio/mars-rover
#
# Have a nice day :)

load 'maps.rb'

class Rover
  def initialize (initial_coordinate, limit)
    ic = initial_coordinate.split(' ')
    li = limit.split(' ')

    @x = ic[0].to_i
    @y = ic[1].to_i
    @direction = ic[2]

    @edgeX = li[0].to_i
    @edgeY = li[1].to_i
  end

  def check_if_is_accessible (value, axis)
    edge = instance_variable_get("@edge#{axis.upcase}")

    is_accessible = value <= edge
    is_in_the_edge = edge === value

    if is_accessible === false
      puts "inaccessible"
      return
    end
    
    if is_in_the_edge === true
      puts "Ohh, I\'m in the edge. This is my #{axis.upcase} axis limit."
    end
  end

  def counter_clockwise
    index   = CARDINAL_DIRECTION.index(@direction)
    length  = CARDINAL_DIRECTION.length

    isInitialValue  = index === 0
    latestValue     = CARDINAL_DIRECTION[(length.to_i - 1)]
    previousValue   = CARDINAL_DIRECTION[(index - 1)]

    isInitialValue ? latestValue : previousValue
  end

  def clockwise
    index   = CARDINAL_DIRECTION.index(@direction)
    length  = CARDINAL_DIRECTION.length

    is_latest_value = index === (length - 1)
    first_value = CARDINAL_DIRECTION[0]
    next_value  = CARDINAL_DIRECTION[(index + 1)]

    is_latest_value ? first_value : next_value
  end

  def turn_left
    @direction = counter_clockwise
  end
  
  def turn_right
    @direction = clockwise
  end

  def increment_axis (axis)
    instance_variable_get("@#{axis}") + 1
  end

  def decrement_axis (axis)
    instance_variable_get("@#{axis}") - 1
  end

  def move_forward
    axis = AXIS_MAP[@direction]
    operation = OPERATIONS_MAP[@direction]

    new_axis_value = send("#{operation}_axis", axis)

    check_if_is_accessible(new_axis_value, axis)

    instance_variable_set("@#{axis}", new_axis_value)
  end

  def execute (instruction)
    send("#{INSTRUCTIONS_MAP[instruction]}")
  end

  def manual_input (instructions)
    instructions.split('').each{|instruction| execute(instruction)}
  end

  def get_positions
    [@x, @y, @direction]
  end
end

rover = Rover.new('1 3 S', '5 5')

rover.manual_input('LMMMM')

puts rover.get_positions()
