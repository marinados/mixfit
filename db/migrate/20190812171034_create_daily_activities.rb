class CreateDailyActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_activities do |t|
    	t.references :user
    	t.integer :vitamin_c_consumption
    	t.integer :vitamin_d3_consumption
    	t.integer :iron_consumption

    	t.timestamps
    end
  end
end
