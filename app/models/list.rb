class List < ActiveRecord::Base

  def self.unarchived
    where(archive: false)
  end

  def self.archived
    where(archive: true)
  end
end
