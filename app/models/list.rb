class List < ActiveRecord::Base
  has_many :tasks

  before_destroy :ensure_archived

  validates :title, uniqueness: true

  def self.unarchived
    where(archive: false)
  end

  def self.archived
    where(archive: true)
  end

  def self.with_completed_tasks
    joins(:tasks).merge(Task.completed).uniq
  end


  private

  def ensure_archived
    self.archive
  end
end
