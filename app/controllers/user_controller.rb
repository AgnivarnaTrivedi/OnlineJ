class UserController < ApplicationController
  def update
    if current_user.username.blank? || current_user.college.blank?
      redirect_to '/users/update_form'
    else
      redirect_to root_path
    end
  end

  def update_form
    @user_page = true
  end

  def save_update
    current_user.update_attributes(username: params[:username],
                                   college: params[:college], name: params[:name])
    flash[:notice] = 'Welcome !!'
    redirect_to root_path
  end

  def checkuser
    username = params[:username]
    user = User.by_username(username).first
    data = {}
    data[:status] = if user.nil?
                      'OK'
                    else
                      'fail'
                    end
    respond_to do |format|
      format.json { render json: data }
    end
  end

  def profile
    @profile_page = true
    username = params[:username]
    puts username
    user = User.by_username(username).first
    @user = []
    @user << { name: user.name, username: user.username, college: user.college }
    submissions = user.submissions
    problems = submissions.where(status_code: 'AC').distinct(:problem)
    @solved_problem = []
    @solved_contest = []
    problems.each do |problem|
      p = Problem.find_by(_id: problem)
      @solved_problem << { contest_code: p.contest[:ccode], problem_code: p[:pcode] }
    end
  end
end
