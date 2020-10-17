# frozen_string_literal: true

class User < ActiveRecord::Base
  rolify before_add: :delete_previous_role
  extend Devise::Models
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, authentication_keys: %i[email username]
  include DeviseTokenAuth::Concerns::User

  mount_uploader :avatar, AvatarUploader

  has_many :articles
  has_many :schedules

  validate :validate_username
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  validates :first_name, :phone_number, :programming_skill, presence: true

  enumerize :programming_skill, in: { beginner: 1, intermediate: 2, advanced: 3, professional: 4, expert: 5 }

  after_create :assign_default_role

  def admin?
    has_role?(:admin)
  end

  def user?
    has_role?(:user)
  end

  def author?
    has_role?(:author)
  end

  def mentor?
    has_role?(:mentor)
  end

  private

  def validate_username
    return unless User.where(email: username).exists?

    errors.add(:username, :invalid)
  end

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def delete_previous_role(assigned_role)
    return if roles.pluck(:name).include?(assigned_role.name)

    roles.delete(roles.where(id: roles.ids))
  end
end
