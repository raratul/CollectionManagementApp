class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :collection, optional: true

  validates :summary, presence: true
  validates :priority, presence: true

  attribute :jira_ticket_url, :string

  before_create :set_default_status

  private

  def set_default_status
    self.status ||= 'Opened'
  end
end
