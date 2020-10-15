# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, authentication_keys: %i[email username]
  include DeviseTokenAuth::Concerns::User

  mount_uploader :avatar, AvatarUploader

  validate :validate_username
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  validates :first_name, :phone_number, :programming_skill, :avatar, presence: true

  enumerize :programming_skill, in: { beginner: 1, intermediate: 2, advanced: 3, professional: 4, expert: 5 }

  private

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end
