class Schedule < ApplicationRecord
  extend Enumerize

  belongs_to :category
  belongs_to :mentor

  validates :title, :description, :google_form_link, :event_date, :schedule_type, :status, presence: true

  enumerize :schedule_type, in: %i[workshop seminar academy]
  enumerize :status, in: %i[finish ongoing coming]
end
