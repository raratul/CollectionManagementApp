require 'open4'

class TicketsController < ApplicationController
  before_action :authenticate_user!

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.tickets.build(ticket_params)
    @ticket.status = 'Opened'

    collection_name = Collection.find_by(id: @ticket.collection_id)&.name || 'N/A'

    response = create_issue_via_bash(
      summary: @ticket.summary,
      description: collection_name,
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
      curl -u rkhairulislam@gmail.com:ATATT3xFfGF0PAbAt3Mkdyrs6TqvugnsrT1LIMZXL9oDG3A7A1w9G0DlsV0M69QfpDOAOp7demuKvy1o14r7Lemg16Y8sYNmUvt5WddLmd5mwrOj-TFdH05v1I8sCROpoH8GJYVfVpirHSF8U8qR7KMhwifzsFRL3PcQlyIDm_Elo1TnP285g-Q=6E185CB7 \
           -X POST \
           --data '{
             "fields": {
               "project": {
                 "key": "CMA"
               },
               "summary": "#{summary}",
               "description": "Collection Name: #{description}",
               "issuetype": {
                 "name": "Support"
               }
             }
           }' \
           -H "Content-Type: application/json" \
           https://collectionmanagementapp.atlassian.net/rest/api/2/issue/
    BASH

    status = Open4::popen4(command) do |pid, stdin, stdout, stderr|
      out = stdout.read.strip
      err = stderr.read.strip
      success = pid.value.success?

      OpenStruct.new(
        success?: success,
        stdout: out,
        stderr: err
      )
    end

    status
  end
end
