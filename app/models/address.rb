class Address < ApplicationRecord
  belongs_to :user

  def to_s
    address = ""

    address += "#{self.line_1}, "
    address += "#{self.line_2}, " if self.line_2
    address += "#{self.city}, #{self.state}, "
    address += "#{self.country} #{self.postal_code}"

    address
  end
end
