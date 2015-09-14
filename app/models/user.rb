class User < ActiveRecord::Base



def self.save_or_update message_post,row

u = User.where("id = ?", row["user_id"].to_i)

if u.blank?
	u = User.new 
	u.name = message_post.posters_name
	u.profile_link = row["post_user_link"]
	u.followed_by = message_post.followed_by
	u.posts = message_post.posts_count
	u.boards_moderated = message_post.posters_moderated_boards
	u.id = row["user_id"].to_i
	u.save
end
			
			
	
end # Save Or Update



end
