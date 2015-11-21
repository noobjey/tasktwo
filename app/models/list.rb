class List < ActiveRecord::Base

  def self.unarchived
    where(archive: false)
  end
end
