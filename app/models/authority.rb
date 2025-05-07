class Authority < ApplicationRecord
       # Include Devise modules.
       # You can add or remove modules depending on your needs.
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
     
       # Add any associations or validations if needed.
       # Example:
       # has_many :complaints
     
       validates :email, presence: true, uniqueness: true
end