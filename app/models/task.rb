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
    "incomplete"
  end
end
