class AddDetailsToServicenowApi < ActiveRecord::Migration[7.0]
  def change
    add_column :servicenow_apis, :active, :integer
    add_column :servicenow_apis, :state, :integer
    add_column :servicenow_apis, :priority, :integer
  end
end
