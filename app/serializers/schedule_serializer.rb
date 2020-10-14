class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :google_form_link, :schedule_type,
             :status, :learning_tool, :event_date, :category, :mentor

  def category
    object.try(:category).name
  end

  def mentor
    object.try(:mentor).first_name
  end
end
