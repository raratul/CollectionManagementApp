require 'open3'

class TicketsController < ApplicationController
  before_action :authenticate_user!

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.tickets.build(ticket_params)
    @ticket.status = 'Opened'

    collection_name = Collection.find_by(id: @ticket.collection_id)&.name || 'N/A'
    description = "Reported by: #{current_user.email}, Collection Name: #{collection_name}"

    response = create_issue_via_bash(
      summary: @ticket.summary,
      description: description,
    )

    @ticket.jira_ticket_url = "https://collectionmanagementapp.atlassian.net/jira/software/projects/CMA/boards/1"

    if @ticket.save
      flash[:notice] = 'Ticket has been created successfully!'
      redirect_to profile_path(current_user)
    else
      render :new
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:summary, :priority, :collection_id)
  end

  def create_issue_via_bash(summary:, description:)
    command = <<-BASH
      curl -u rkhairulislam@gmail.com:#{ENV['issue_api_key']} \
           -X POST \
           --data '{
             "fields": {
               "project": {
                 "key": "CMA"
               },
               "summary": "#{summary}",
               "description": "#{description}",
               "issuetype": {
                 "name": "Support"
               }
             }
           }' \
           -H "Content-Type: application/json" \
           https://collectionmanagementapp.atlassian.net/rest/api/2/issue/
    BASH

    stdout, stderr, status = Open3.capture3(command)

    OpenStruct.new(
      success?: status.success?,
      stdout: stdout,
      stderr: stderr
    )
  end
end
