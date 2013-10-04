class AddCurrentToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :current, :boolean, :default => false
  end
end
