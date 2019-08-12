class CreateFoodIntakes < ActiveRecord::Migration[5.2]
  def change
    create_table :food_intakes do |t|
    	t.references :user
    	t.integer :vitamin_c
    	t.integer :vitamin_d3
    	t.integer :iron
    end
  end
end
