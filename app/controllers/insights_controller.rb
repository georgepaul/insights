class InsightsController < ApplicationController


def mostmentioned
    
@most_mentioned = WordToPosts.most_mentioned_ticker

render :json => @most_mentioned

end

end
