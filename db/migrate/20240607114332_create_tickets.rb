class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :collection, foreign_key: { on_delete: :cascade }
      t.string :summary
      t.string :priority
      t.string :status
      t.string :jira_ticket_url

      t.timestamps
    end
  end
end
