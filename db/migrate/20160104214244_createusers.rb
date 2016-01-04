class Createusers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :password
  		t.string :fname
  		t.string :lname
  		t.text :bio
  		t.timestamps null: false
  	end
  end
end
