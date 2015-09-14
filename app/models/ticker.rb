class Ticker < ActiveRecord::Base
    
    
def self.live_quote ticker=nil
   StockQuote::Stock.quote(ticker)
end

def self.historical_quote ticker,start_date=(Time.now - 24.hours),end_date=(Time.now + 24.hours)
    stock = StockQuote::Stock.quote(ticker,start_date,end_date)
end 




    
end
