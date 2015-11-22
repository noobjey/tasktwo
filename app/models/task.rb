class Task < ActiveRecord::Base
  belongs_to :list

  def status_string
    return "completed" if self.status
    "incomplete"
  end
end
