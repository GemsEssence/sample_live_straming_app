class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :name
      t.string :session_id

      t.timestamps
    end
  end
end
