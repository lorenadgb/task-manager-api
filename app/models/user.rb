class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # attr_accessor :name
  #
  # validates :name, presence: true

  validates :auth_token, uniqueness: true

  def info
    "#{email} - #{created_at} - Token: #{Devise.friendly_token}"
  end
end
