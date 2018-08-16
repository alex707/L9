# description for routes.
class Route
  include InstanceCounter
  include Validation

  attr_reader :intermediate, :st_begin, :st_end

  def initialize(st_begin, st_end)
    @st_begin  = st_begin
    @st_end    = st_end

    @intermediate = []

    validate!
    register_instance
  end

  def validate!
    unless st_begin.is_a?(Station) && st_end.is_a?(Station)
      raise 'Station begin and station end must be a station object!'
    end

    true
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def add_station(station)
    @intermediate << station
  end

  def delete_station(st_name)
    @intermediate.delete_if { |s| s.name == st_name }
  end

  def stations
    [@st_begin] + @intermediate + [@st_end]
  end
end
