class Board < ActiveRecord::Base
@@page

def self.update_boards
agent = Mechanize.new
agent.user_agent_alias = 'Windows Mozilla'

categories = BoardCategory.all
bc = Array.new

categories.each do |category|
bc.push category if category.id < 80
end

bc.each do |bc|
next_start = bc.full_link

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


def self.latest_post_before threshold=30.days.ago.to_date 
boards = Board.where("last_post > ?", threshold)
end

end
