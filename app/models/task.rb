class Task < ActiveRecord::Base
  belongs_to :list

  def self.uncompleted
    Task.where(status: false)
  end

  def self.completed
    Task.where(status: true)
  end

  def status_string
    return "complete" if self.status
    "active"
  end

  def due_date_formatted
    self.due_date.strftime("%d %B %Y")
  end
end
