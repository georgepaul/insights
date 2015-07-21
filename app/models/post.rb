class Post < ActiveRecord::Base


def self.body_to_words

posts = Post.all

posts.each do |p|

words = p.post_body.split(" ")
words.each do |word|
	logger.warn(p.inspect)
word_record_id = Words.add_word word


		a = WordToPosts.new
		a.post_id = p.id
		a.word_id = word_record_id
		a.user_id = p.user_id
		a.source_type = 1
	a.save
end

end

posts = Post.find(:all)

posts.each do |p|
words = p.post_title.split(" ")
words.each do |word|
word_record = Words.add_word word
		a = WordToPosts.new
		a.post_id = p.id
		a.word_id = word_record.id
		a.user_id = p.user_id
		a.source_type = 2
	a.save
end
end

	
end


def self.save_or_skip message_post,row,board

	row_link = row["post_title_link"]
	message_id = row_link[row_link.index("message_id=")+11,row_link.length]
	logger.warn("message_id")
	logger.warn(message_id)
	p = Post.where("message_id = ?", message_id) 

	if p.blank?
		logger.warn("new post")
		
		begin
		p = Post.new
		p.id = message_id.to_i
		p.post_body = message_post.message_body 
		p.post_number = row["post_number"]
		p.post_title = row["post_title"]
		p.post_date = row["post_date"]
		p.post_link = row["post_title_link"]
		p.message_id = message_id
		p.user_id = row["user_id"]
		p.board_id = board.id
		p.save
		rescue 
		logger.warn("Post Not Saved")
		
		end


	end

end

def self.update_all
require 'rubygems'
require 'mechanize'
agent = Mechanize.new
agent.user_agent_alias = 'Windows Mozilla'
boards = Board.latest_post_before 30.days.ago.to_date

boards.each do | board |
	next_page = board.full_link
	logger.warn(board.name) unless board.blank?
	agent.add_auth(next_page, 'georgepaul@live.ca', '8751Qwer')

	begin
		page = Page.new next_page
		a = page.next_start
		@currentrow

	if a == false
		sleep(60.seconds)
	else
		next_page = a
		rows = page.posts
		rows.each_with_index  do |row,index|
			@currentrow = row
			message_post = Page.new row["post_title_link"]
	
		if message_post.message_body.nil? || message_post.message_body.blank?
		sleep(60.seconds) 
		message_post = Page.new row["post_title_link"]
		end

		p = Post.save_or_skip message_post,row,board
		u = User.save_or_update message_post,row

		end
	end # if a == false
end while (Tablerow.is_after_date @currentrow["post_date"])
end #boards.each do | board |

end



end
