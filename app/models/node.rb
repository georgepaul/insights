class Node < ActiveRecord::Base

@@element

def initialize element

@@element = element

end


def _username_from_table_row node=nil
	@@element.search("td")[2].at("a")["href"]
end

def _username_link node=nil
end 

def _user_id node=nil
end 

def _post_title node=nil
end

def _post_title_link node=nil
end

def _post_id node=nil
end

def _post_number node=nil
end

def _date_from_table_row node=nil
	@@element.search("td")[3].inner_html
end








end
