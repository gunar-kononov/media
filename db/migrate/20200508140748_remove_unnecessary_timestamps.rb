class RemoveUnnecessaryTimestamps < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :created_at
    remove_column :movies, :updated_at
    remove_column :seasons, :created_at
    remove_column :seasons, :updated_at
    remove_column :episodes, :created_at
    remove_column :episodes, :updated_at
  end
end
