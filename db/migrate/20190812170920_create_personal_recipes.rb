class CreatePersonalRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :personal_recipes do |t|
    	t.references :user
    	t.integer :vitamin_c_dosage
    	t.integer :vitamin_d3_dosage
    	t.integer :iron_dosage
    	t.timestamps
    end
  end
end
