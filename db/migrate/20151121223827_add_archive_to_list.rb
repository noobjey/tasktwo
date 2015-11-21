class AddArchiveToList < ActiveRecord::Migration
  def change
    add_column :lists, :archive, :boolean, default: false
  end
end
