# methods for working with cargo trains
class CargoTrain < Train
  def car_connect(car)
    @cars << car if car.is_a?(CargoCar)
  end
end
