class Logic < ActiveRecord::Base #PageLogic and associate Data




def self.scrape
require 'rubygems'
require 'mechanize'
end


def self.all_board_categories
self.scrape
page = Page.new "http://investorshub.advfn.com/boards/hubstocks.aspx"
page.board_categories
end

def self.all_boards
self.scrape 
board_categories = BoardCategory.all
board_categories.each_with_index do |bc|
base_url = bc.full_link
next_start = base_url
count = 0
board_category_page = Page.new next_start
last_page = board_category_page.board_category_last_page
	
	begin
		rows = board_category_page.board_category_rows
		#Update Board Logic
		rows.each_with_index do |row,index|
			Board.update_board row
		end
		next_start = base_url + "&page=" + (count + 1)
	end while (count < last_page)

end
end
end

def self.update_boards
Board.update_boards
end


def self.posts

self.scrape
agent = Mechanize.new
agent.user_agent_alias = 'Windows Mozilla'
boards = Board.latest_post_before 30.days.ago.to_date

boards.each_with_index do |board,index|
	boards.delete_at(index) if board.id < 13111
end

boards.each do | board |
	next_page = board.full_link
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







#end
#end


=begin
page = Page.new "http://investorshub.advfn.com/STOCKGOODIES-PLAYS-OF-THE-WEEK-18582/"

rows = page.posts
return rows
end

rows.each do |row|
logger.warn(row.inspect)
end

agent.get('http://investorshub.advfn.com/boards/read_msg.aspx?message_id=115162069') do |page|
=end
#page.search(".KonaBody").at("span").text

#page = Page.new 'http://investorshub.advfn.com/boards/read_msg.aspx?message_id=115162069'
#logger.warn(page.message_body)
#logger.warn(page.posters_name)
#logger.warn(page.posters_id)
#logger.warn(page.posts_count)
#logger.warn(page.posters_moderated_boards)

# USER NAMElogger.warn(page.search(".msgparts1.msgparts2 table tr td")[1].at("a").text)

# Followed BY logger.warn(page.search(".msgparts1.msgparts2 table tr td")[3].text)
#Posts logger.warn(page.search(".msgparts1.msgparts2 table tr td")[5].text)
# Boards Moderated logger.warn(page.search(".msgparts1.msgparts2 table tr td")[7].text)
#Alias Born logger.warn(page.search(".msgparts1.msgparts2 table tr td")[9].text)

#page.search(".msgparts1.msgparts2 table")[1]

#end

#page = Page.new 'http://investorshub.advfn.com/STOCKGOODIES-PLAYS-OF-THE-WEEK-18582/'

#logger.warn("***nextstart***")
#logger.warn(page.next_start)
#logger.warn(page.next_start_link)


=begin

agent.get('http://investorshub.advfn.com/STOCKGOODIES-PLAYS-OF-THE-WEEK-18582/') do |page|
page.search(".dtor,.dter").each do |table_row,index|
row = Tablerow.new table_row
#logger.warn(row.date)
logger.warn("Table Row User Id")
logger.warn(row.user_id)
logger.warn(row.user_profile_link)
logger.warn(row.username)
#logger.warn(row.user_id_from_table_row)
#logger.warn(table_row.search("td")[2].at("a")["href"]) unless table_row.search("td")[2].nil? #UserName Link
#logger.warn(table_row.search("td")[2].at("a").text) unless table_row.search("td")[2].nil? #UserName Text
#name = 
#logger.warn(table_row.search("td")[2].at("a").text[table_row.search("td")[2].at("a").text.index("="),table_row.search("td")[2].at("a").text.length]) unless table_row.search("td")[2].nil?
end

#page.search('#ctl00_CP1_gv tr').each do |table_row,index|
			#table_row.search("tr td")
			#logger.warn(table_row)
			#logger.warn( table_row.search("td span") )
			#logger.warn( table_row.search("td span").text )


#logger.warn("Date") DONE
#logger.warn(table_row.search("td")[3].inner_html) unless table_row.search("td")[3].nil?

#logger.warn("UserName") DONE
#logger.warn(table_row.search("td")[2].at("a")["href"]) unless table_row.search("td")[2].nil?
#logger.warn(table_row.search("td")[2].at("a").text) unless table_row.search("td")[2].nil?

#Post Title
#logger.warn("Post Title")
#logger.warn(table_row.search("td")[1].at("a")["href"]). unless table_row.search("td")[1].nil?
#logger.warn(table_row.search("td")[1].at("a").text).nil? unless table_row.search("td")[1].nil?


#Post Number
#logger.warn("PostNumber")
#logger.warn(table_row.search("td")[0])



=begin
table_row.search("td").each_with_index do |td,index|
logger.warn("corresponding index")
logger.warn(index) # INDEX 3 td. Text is a given date and time of post
#index 0 is a post number
#index 1 is a post title
#index 2 is username
#index 3 is the date
logger.warn(td.text)
#Anchor Tags
unless td.at("a").nil?
#logger.warn(td.at("a")["href"]) #Link FINISHED # ALso grab seperate message_id for every href string is different from post #
#logger.warn(td.at("a").text) #Text FINSHED
#logger.warn(td.last)
end


#If Date is past a certain Date End Scraping

#end date not reached then ...
#IF TD TEXT CONTAINS TEXT OLDER, Grab this link, pull this page keep going until you run into the end date

				#logger.warn(td.search("a").children) # Anchor's Title
				#logger.warn(td.search("a").text) # Read Post Link
	 			#logger.warn(td.search("a")["href"]) # Html string Anchor
	 			#logger.warn(td.search("a").text.strip) # Read Post Link
				#logger.warn(td.search("a").to_a.attributes) # Read Post Link
				logger.warn("GGGt")
				#logger.warn(td.search("a").to_a[2]) # User Link

			end
=end
			#logger.warn( table_row.search("td span").text )

			#logger.warn( table_row.search("td span").text )

			#puts table_row.css('td')[0]
#			logger.warn "***************"
			
#		end 


#end


#HOW DO I GET THE NEXT PAGE LINK AND THEN PAGE TO IT, REPEAT ABOVE
#end




