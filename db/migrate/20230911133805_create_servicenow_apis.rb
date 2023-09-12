class CreateServicenowApis < ActiveRecord::Migration[7.0]
  def change
    create_table :servicenow_apis do |t|
      t.string :number
      t.string :email
      t.integer :impact
      t.string :caller_id
      t.string :short_description
      t.string :assigned_to

      t.timestamps
    end
  end
end
