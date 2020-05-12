class Meeting < ApplicationRecord
  before_create do |meeting|
    session = OpenTokClient.create_session
    meeting.session_id = session.session_id
  end

  validates :name, presence: true

  has_many :meeting_users, dependent: :destroy
  has_many :users, through: :meeting_users

  def to_param
    session_id
  end
end
