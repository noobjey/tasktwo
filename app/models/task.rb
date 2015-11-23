class Task < ActiveRecord::Base
  belongs_to :list

  validates :title, presence: true, allow_blank: false
  validate :valid_due_date

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


  private

  def valid_due_date
    if !due_date.is_a?(Date) && turn_into_date?(due_date)
      errors.add(:due_date, "Must enter a valid date.")
      false
    else
      true
    end
  end

  def turn_into_date?(due_date)
    ((Date.parse(due_date) rescue ArgumentError) == ArgumentError)
  end
end


