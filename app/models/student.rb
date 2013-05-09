require_relative '../../db/config'

class Student < ActiveRecord::Base

  validates :phone, :format => { :with => /\W?\d{3}\W?\s?\d{3}\W?\s?\d{4}\s?\W?x?\d{4}?/, :message => "Only valid phone numbers allowed."}
  validates :email, :format => { :with => /\w+@\w+.\w{2,}/, :message => "Only valid emails allowed." }
  validates :email, :uniqueness => true
  validate :validates_age

  def age
    now = Date.today
    age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def validates_age
    if self.age < 5
      errors.add(:birthday, "Age cannot be under 5.")
    end
  end

end
