# module for company description.
module Company
  include Validation

  attr_accessor :company_name

  validate :company_name, :presence

  def initialize(company_name)
    @company_name = company_name

    validate!
  end
end
