class TimelineController < ApplicationController
  def index
    @tasks = Task.all
  end
end
