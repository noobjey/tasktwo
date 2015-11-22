class List < ActiveRecord::Base
  before_destroy :ensure_archived

  validates :title, uniqueness: true

  def self.unarchived
    where(archive: false)
  end

  def self.archived
    where(archive: true)
  end


  private

  def ensure_archived
    self.archive
  end
end
