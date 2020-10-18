class ScheduleSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :id, :title, :description, :google_form_link, :schedule_type,
             :status, :learning_tool, :event_date, :count_down, :category, :mentor

  def category
    category = object.try(:category)
    {
      id: category.try(:id),
      name: category.try(:name)
    }
  end

  def mentor
    mentor = object.try(:mentor)
    {
      id: mentor.try(:id),
      first_name: mentor.try(:first_name),
      last_name: mentor.try(:last_name),
      avatar: { url: mentor.try(:avatar).url }
    }
  end

  def event_date
    object.try(:event_date).in_time_zone(Time.zone).strftime('%d-%m-%Y %T %Z')
  end

  def count_down
    return 'done' if object.try(:event_date) < Time.zone.now

    distance_of_time_in_words(object.try(:event_date), Time.zone.now)
  end

  def status
    return 'coming' if object.try(:event_date) > Time.zone.now

    'finish'
  end
end
