class HomeController < ApplicationController
  before_action :check
  def index
    @home_page = true
    upcoming_contests = Contest.upcomming
    running_contests = Contest.running
    past_contests = Contest.past
    @Contests = []
    @Contests << { name: 'Upcoming Contests', data: upcoming_contests }
    @Contests << { name: 'Running Contests', data: running_contests }
    @Contests << { name: 'Past Contests', data: past_contests }
  end
end
