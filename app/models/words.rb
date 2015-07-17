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


end
