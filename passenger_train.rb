# discription passenger wagons
class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER

  validate :train_type, :presence
  validate :train_type, :format, TRAIN_TYPE
  validate :train_type, :type, String

  def car_connect(car)
    @cars << car if car.is_a?(PassengerCar)
  end
end
