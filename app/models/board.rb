class Board < ActiveRecord::Base
@@page
@@agent=nil
require 'rubygems'
require 'mechanize'

def self.test_record

b = Board.new 
b.name = "TEST"
b.save
end


def self.update_boards # retrived all active boards from ihub
agent = Mechanize.new
agent.user_agent_alias = 'Windows Mozilla'
categories = BoardCategory.all
bc = Array.new
categories.each do |category|
bc.push category if category.id < 80
end
bc.each do |bc|
next_start = bc.full_link
logger.warn(bc.full_link)
agent.add_auth(next_start, 'georgepaul@live.ca', '8751Qwer')
count = 0
last_page = 0
begin
	begin
			agent.get(next_start) do |page|
				@@page = page
			end	

			if @@page.blank?
				sleep(60.seconds) 
				agent.get(next_start) do |page|
				@@page = page
				end	
			end
	rescue
			sleep(80.seconds)
				agent.get(next_start) do |page|
				@@page = page
				end	
	end

if (last_page == 0)
unless @@page.at("a:contains('Last >')").nil?
last_page = @@page.at("a:contains('Last >')")["href"] 
last_page = last_page[last_page.index("page=")+5,last_page.length].to_i
else
last_page=1
end
end

@@page.search(".dtor,.dter").each_with_index do |table_row,index|
	row = Tablerow.new table_row
	rowhash = { "board_name" => row.board_name,
		"board_url" => row.board_url,
		"board_total_posts" => row.board_total_posts,
		"board_latest_post" => row.latest_post,
		"board_category_id" => bc.id
	}
		Board.update_board rowhash
	end
		
		count = count + 1
		next_start = bc.full_link + "&page=" + (count).to_s
end while(count <= last_page)
end # Looping Through All Board Category Pages
end #End Method


def next_start
href = @@page.at("a:contains('Next >')")["href"] 
return false if href.blank?
return 'http://investorshub.advfn.com' + href
end


def self.update_board row=nil

begin 
r = Board.where(:name => row["board_name"])
if r.blank?
b = Board.new 
b.name =  row["board_name"]
b.board_link = row["board_url"]
b.latest_post = row["board_latest_post"]
b.board_category_id = row["board_category_id"]
b.save
end
rescue
logger.warn("Board Not Saved")
return true
end



end

def full_link
'http://investorshub.advfn.com' + self.board_link[self.board_link.index("/"),self.board_link.length]
end


def self.latest_post_to_date_time
Board.all.each do |board|
board.last_post = DateTime.strptime(board.latest_post,"%m/%d/%Y %I:%M:%S %p")
board.save
end	

end 

def self.all_board_categories
require 'rubygems'
require 'mechanize'
page = Page.new "http://investorshub.advfn.com/boards/hubstocks.aspx"
page.board_categories
end


def self.latest_post_before threshold=30.days.ago.to_date 
boards = Board.where("last_post > ?", threshold)
end


def posts_from_board threshold=1.day.ago.to_date
next_page = self.full_link

begin
		page = Page.new next_page
		next_page = page.next_start
		rows = page.posts
		
		logger.warn("page posts"); "==============================>"
		logger.warn(rows.length);
		# ROWS remove any rows already in the db set next_page to false IF any of the rows r in the db

unless rows.length == 0
rows.each_with_index  do |row,index|
			@lastrow = row 
			logger.warn(@lastrow)
			message_post = Page.new row["post_title_link"]
			if message_post.message_body.nil? || message_post.message_body.blank?
			logger.warn("Sleeping a")
			sleep(1.minutes) 
			message_post = Page.new row["post_title_link"]
			end
			p = Post.save_or_skip message_post,row,self
			u = User.save_or_update message_post,row
		end
else
	@lastrow = {"post_date" => 15.days.ago.to_datetime}
	break
end


	
	
			
end while (Tablerow.is_after_date @lastrow["post_date"], threshold || next_page == false)
end


def self.update_all_posts threshold=14.days.ago

boards = Board.latest_post_before threshold.to_date



boards.each do | board |
	board.posts_from_board threshold
end #boards.each do | board |
end

def self.update_from_last_board_forward threshold=14.days.ago

#boards = Board.latest_post_before threshold.to_date #return all boards with the last post within the last 14 days
boards = Board.where('id > 0');
#boards = Board.where("id > ?", 2920)
#boards = Board.where("id > ?", 2943)
#find last post created_at, take that board_id, do all boards from that board forward
@post = Post.order("created_at").last # retrieve the last post we saved for continuation


boards.each do | board |
logger.warn(board)	

	unless @post.nil?

	board.posts_from_board threshold if board.id >= @post.board_id # Skip over posts from before our last post
	else
		
		board.posts_from_board threshold
	end

end #boards.each do | board |

end

def self.post_test threshold = 14.days.ago

#boards = Board.latest_post_before threshold.to_date #return all boards with the last post within the last 14 days
#boards = Board.where('board.id > 2845');
boards = Board.where("id > ?", 2844)
#find last post created_at, take that board_id, do all boards from that board forward
@post = Post.order("created_at").last # retrieve the last post we saved for continuation


boards.each do | board |
logger.warn(board)	

	unless @post.nil?

	board.posts_from_board threshold # Skip over posts from before our last post
	else
		
		board.posts_from_board threshold
	end

end #boards.each do | board |

end






















end
