class CreateMeetingUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :meeting_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meeting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
