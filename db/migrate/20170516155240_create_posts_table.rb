class CreatePostsTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :blogs do |t|
  		t.string :title
  		t.string :category
  		t.text :content
  	end
  end
end
