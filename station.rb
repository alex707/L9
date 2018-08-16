# stations discription
class Station
  include InstanceCounter
  include Validation

  attr_accessor :name

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /^.{1,14}$/i

  @@all = [] # rubocop:disable Style/ClassVars

  def initialize(name)
    @name   = name

    @trains = []
    @@all << self

    validate!
    register_instance
  end

  # def validate!
  #   raise 'Name can not be nil' if name.nil?
  #   raise 'Name should be at least 1' if name.empty?
  #   true
  # end

  # def valid?
  #   validate!
  # rescue StandardError
  #   false
  # end

  def take_train(train)
    @trains << train
  end

  def kick_train(train)
    @trains.delete(train)
  end

  def trains(type = nil)
    # return all
    if type.nil?
      @trains

    # return by type
    else
      @trains.select { |train| train.type == type.to_s }
    end
  end

  def trains_count(type = nil)
    # method return number of 'cargo' or 'pass' trains
    # if type is null, then will return count of all trains on the st

    return if @trains.empty?

    # return all
    if type.nil?
      @trains.size

    # return by type
    else
      @trains.select { |train| train.type == type.to_s }.size
    end
  end

  # rubocop:disable Metrics/MethodLength
  def send_train(number = nil)
    return if @trains.empty?

    if number.nil?
      @trains.first.go_to_next_st
    else
      @trains.each do |train|
        if train.number == number.to_s
          train.go_to_next_st
          break
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def self.all
    @@all
  end

  def bypass
    @trains.map do |train|
      yield(train)
    end
  end
end
