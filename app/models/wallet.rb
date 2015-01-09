class Wallet < ActiveRecord::Base
  # consider adding currency flag
  belongs_to :user

  validates :balance, :numericality => { :greater_than_or_equal_to => 0.0 }
end
