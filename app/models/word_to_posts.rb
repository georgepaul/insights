class WordToPosts < ActiveRecord::Base
    
def self.most_mentioned_ticker 
WordToPosts.find_by_sql("SELECT count(word_to_posts.word_id) as 'wordcount', words.name from word_to_posts,words where word_to_posts.word_id IN (SELECT id from words where is_ticker = 1) AND word_to_posts.word_id = words.id")
end

def self.most_uniquely_mentioned_ticker
end 

def all_ticker_mentions #For a Given USER
end

def who_mentioned #Users For a Given Ticker
    
end

    
end
