class MeetingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @meetings = current_user.meetings
  end


  def show
    @meeting = current_user.meetings.find_by_session_id(params[:id])
    gon.opentok = opentok_data(@meeting)
  end


  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.meeting_users.build(user: current_user)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meetings_path, notice: 'Meeting was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  private

    def meeting_params
      params.require(:meeting).permit(:name, user_ids: [])
    end

    def opentok_data(meeting)
      token = OpenTokClient.generate_token(meeting.session_id)
      { sessionId: meeting.session_id, apiKey: Figaro.env.opentok_api_key, token: token, email: current_user.email }
    end
end
