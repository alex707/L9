# train description
class Train
  include InstanceCounter
  include Company
  include Validation
  extend Accessors

  attr_reader :route, :train_type, :cars

  attr_accessor_with_history :speed

  strong_attr_accessor :number, String

  @@all = {} # rubocop:disable Style/ClassVars

  TRAIN_NUMBER  = /^([a-z]{3}|\d{3})(-{1}[a-z]{2}|-{1}\d{2}|[a-z]{3}|\d{3})$/i
  TRAIN_TYPE    = /^((pass){1}|(cargo){1})$/

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER

  validate :train_type, :presence
  validate :train_type, :format, TRAIN_TYPE
  validate :train_type, :type, String

  def initialize(number, type)
    @number     = number
    @train_type = type

    self.speed  = 0

    @st_number  = nil
    @route      = nil
    @cars       = []
    @@all[number] = self

    validate!
    register_instance
  end

  def accelerate
    self.speed += 5
  end

  def breake
    self.speed = 0
  end

  def route=(route)
    @route = route

    @st_number = 0
    station.take_train self
  end

  # rubocop:disable Style/GuardClause
  def go_to_next_st
    if @st_number != @route.stations.size - 1
      station.kick_train self
      @st_number += 1
      station.take_train self
    end
  end

  def go_to_prev_st
    if @st_number.nonzero?
      station.kick_train self
      @st_number -= 1
      station.take_train self
    end
  end
  # rubocop:enable Style/GuardClause

  def prev_st
    @route.stations[@st_number - 1] unless @st_number.nil?
  end

  def station
    @route.stations[@st_number] unless @st_number.nil?
  end

  def next_st
    @route.stations[@st_number + 1] unless @st_number.nil?
  end

  def cars_count
    @cars.size
  end

  def car_disconnect
    @cars.delete_at(-1).status = false
  end

  def find(number)
    @@all[number]
  end

  def bypass
    @cars.map do |c|
      yield(c)
    end
  end
end
