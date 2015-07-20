class BoardCategory < ActiveRecord::Base


def full_link
'http://investorshub.advfn.com/boards/' + self.link
end


end
