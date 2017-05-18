class AddUserIdAndBlogIdCommentsTable < ActiveRecord::Migration[5.1]
  def change
  	change_table :comments do |t|
  		t.integer :user_id
  		t.integer :blog_id
  	end
  end
end
