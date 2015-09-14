# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :environment, :development
set :path, "/c/Sites/insights"
 set :output, "/c/Sites/insights/log/cron.log"
#
 every 1.minute do
  runner "Board.test_record"
 end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
