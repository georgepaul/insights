class Page 
	@@page
require 'rubygems'
require 'mechanize'

def initialize url
#Read Message
#Board Page


	@url = url
	agent = Mechanize.new
	agent.user_agent_alias = 'Windows Mozilla'
	agent.add_auth(url, 'georgepaul@live.ca', '8751Qwer')
	
	begin 
		agent.get(url) do |page|
			@@page = page
		end	
	rescue => e

		if e.status == 403
		agent.add_auth(url, 'georgepaul@live.ca', '8751Qwer')
			
			agent.get(url) do |page|
				@@page = page
			end		
		else
		logger.warn("Bad Auth")
		end
	end
end



def board_categories
@@page.search(".hubcat table td a").each_with_index do |anchor,index|
bc = BoardCategory.new
bc.id = anchor["href"][anchor["href"].index("cat_id=")+7,anchor["href"].length]
bc.link = anchor["href"]
bc.name = anchor.text
bc.save
end
end


def board_category_rows
rows = Array.new
@@page.search(".dtor,.dter").each_with_index do |table_row,index|
row = Tablerow.new table_row
if row.is_valid_row?
rowhash = { "post_number" => row.post_number,
		"post_title" => row.post_title,
		"post_title_link" => row.post_title_link,
		"post_user" => row.username,
		"post_user_link"=> row.user_profile_link,
		"post_date"=> row.date,
		"user_id" => row.user_id
}
rows.push rowhash
end
end # each with index
return rows
end

def board_category_last_page
begin
link = @page.at("a:contains('Last >>')")["href"]
page = link[link.index("page=")+6,link.length].to_i
return page
rescue 
return false
end
end

def board_category_last_page_href
begin
@page.at("a:contains('Last >>')")["href"]
rescue 
return false
end
end

def page_href
return @url
end

def next_start

unless @@page.at("a:contains('Older')").blank?
href = @@page.at("a:contains('Older')")["href"] 
return "http://investorshub.advfn.com/" + href
else
return false
end

#href = @@page.search("#ctl00_CP1_gv_ctl01_gvhlprev")[0]["href"]
#href = @@page.text_includes("Older")


end


def posts #
rows = Array.new
@@page.search(".dtor,.dter").each_with_index do |table_row,index|
row = Tablerow.new table_row
if row.is_valid_row?
rowhash = { "post_number" => row.post_number,
		"post_title" => row.post_title,
		"post_title_link" => row.post_title_link,
		"post_user" => row.username,
		"post_user_link"=> row.user_profile_link,
		"post_date"=> row.date,
		"user_id" => row.user_id
}
rows.push rowhash
end
end # each with index

return rows
end

def next_start_link
 @@page.search(".whitebold")
end
#User Name logger.warn(page.search(".msgparts1.msgparts2 table tr td")[1].at("a").text)

#Followed BY logger.warn(page.search(".msgparts1.msgparts2 table tr td")[3].text)
#Posts logger.warn(page.search(".msgparts1.msgparts2 table tr td")[5].text)
#Boards Moderated logger.warn(page.search(".msgparts1.msgparts2 table tr td")[7].text)
#Alias Born logger.warn(page.search(".msgparts1.msgparts2 table tr td")[9].text)


### Post Page

def followed_by
	@@page.search(".msgparts1.msgparts2 table tr td")[3].text
end

def message_body
	@@page.search(".KonaBody").inner_text
end

def posters_name
	@@page.search(".msgparts1.msgparts2 table tr td")[1].at("a").text
end

def posters_id
	url = @@page.search(".msgparts1.msgparts2 table tr td")[1].at("a")["href"]
	url = url[ url.rindex("user=") + 5 , url.length ]
end
	 
def posts_count
	@@page.search(".msgparts1.msgparts2 table tr td")[5].text
end

def posters_moderated_boards
	@@page.search(".msgparts1.msgparts2 table tr td")[7].text
end














end
