class Tablerow < ActiveRecord::Base
	@@element

def initialize element
	@@element = element
end

def board_name
name = @@element.search("td")[0].at("a").text

unless @@element.search("td")[1].at("a").nil?
name = name + " | " + @@element.search("td")[1].at("a").text.strip
end

unless @@element.search("td")[2].at("a").nil?
name = name + " | " + @@element.search("td")[2].at("a").text.strip
end


return name
end

def self.numeric?(string)
  # `!!` converts parsed number to `true`
  !!Kernel.Float(string) 
rescue TypeError, ArgumentError
  false
end

def is_valid_row?
a = true unless @@element.search("td")[0].inner_text.index("#").nil?
return true if a 
return false

end

def board_url
unless @@element.search("td")[0].at("a")["href"].nil?
return @@element.search("td")[0].at("a")["href"] unless @@element.search("td")[0].at("a")["href"].index("../").nil?
end

unless @@element.search("td")[1].at("a")["href"].nil?
return @@element.search("td")[1].at("a")["href"] unless @@element.search("td")[1].at("a")["href"].index("../").nil?
end

unless @@element.search("td")[2].at("a")["href"].nil?
return @@element.search("td")[2].at("a")["href"] unless @@element.search("td")[2].at("a")["href"].index("../").nil?
end

end

def board_total_posts
@@element.search("td")[1].text.strip
end

def latest_post
@@element.search("td").last.text
end

def username 
	@@element.search("td")[2].at("a").text
end

def user_profile_link 
	@@element.search("td")[2].at("a")["href"]
end 

def user_id 
	@@element.search("td")[2].at("a")["href"][self.user_profile_link.index("=")+1,self.user_profile_link.length]
end 

def post_id 
	href = @@element.search("td")[1].at("a")["href"]
	href[href.index("message_id")+11,href.length]
end

def post_title 
	
	@@element.search("td")[1].at("a").inner_text
end

def post_title_link 
	"http://investorshub.advfn.com" + @@element.search("td")[1].at("a")["href"]
end

def post_number 
	@@element.search("td")[0].inner_text.gsub("#","").gsub("\r\n","").to_i
end

def past_date? date=Time.now
	@@element.search("td")[3].inner_html
end

def date node=nil
	@@element.search("td")[3].inner_html
end

def self.is_before_date curRow, date=Time.now
return true if DateTime.parse(self.date) < date
end


def self.is_after_date date=Time.now
return true if DateTime.strptime(date,"%m/%d/%Y %I:%M:%S %p") > 30.days.ago.to_date
return false
end

def page_href

end

def next_start
@@element.search()
end

end