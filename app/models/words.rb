class Words < ActiveRecord::Base


def self.add_word word

r = Words.where(:name => word)
	if r.blank?
		w = Words.new
		w.name = word 
		w.save!
		return w.id
	end
return r[0].id

end

def self.find_tickers

Words.all.each do |word|
	
	
		ticker = word.name

if ticker.length == 4
	if ticker == ticker.upcase
		if ticker  =~ /\d/	|| ticker.include?("&") || ticker.include?("!") || ticker.include?("?") || ticker.include?(":")
			logger.warn ("Invalid Ticker")
		else
				word.is_ticker = 1
	 			word.save!
	 	end
	 end
end

end
end

def strip
	w = self.gsub "'",""
	w = self.gsub ".",""
    w =	self.gsub "-",""
	w = self.gsub "$",""
	w = self.gsub ",",""
	return w
end

def self.clean w
	w = w.gsub "'",""
	w = w.gsub ".",""
    w =	w.gsub "-",""
	w = w.gsub "$",""
	w = w.gsub ",",""
	w = w.gsub "'s",""
	w = w.gsub "`s",""
		w = w.gsub ")",""
			w = w.gsub "(",""
			w = w.gsub "?",""
				w = w.gsub '"',""	
			
	return w
end 



end
