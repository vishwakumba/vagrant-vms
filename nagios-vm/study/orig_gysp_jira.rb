require 'json'
require 'net/http'
require 'openssl'
require 'date'

# 417 is SA Activiation, Jira Project's boardId
# curl https://jira.dwp.gov.uk/rest/agile/1.0/board
$JIRA_BOARD_ID      = "417"
$JIRA_USERNAME      = "vishwa.kumba"
$JIRA_PASSWORD      = "Suresh0$"
$JIRA_URL           = "https://jira.dwp.gov.uk"

$today = Date.today
$sprint_details = []
$tasks_total = 0
$tasks_done = 0
$tasks_left = 0
	
$current_sprint_uri = URI("#{$JIRA_URL}/rest/agile/1.0/board/#{$JIRA_BOARD_ID}/sprint?state=active")

def fetch_jira_data
  sprint_name = nil
  str_start_date = nil
  str_end_date = nil
  remaining_days = 0 

  Net::HTTP.start($current_sprint_uri.host, $current_sprint_uri.port,
				  :use_ssl     => $current_sprint_uri.scheme == 'https', 
				  :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

    request = Net::HTTP::Get.new $current_sprint_uri.request_uri
    request.basic_auth $JIRA_USERNAME, $JIRA_PASSWORD

    current_sprint_response = http.request request
    current_sprint_response_json = JSON.parse(current_sprint_response.body)

    sprint_id  = current_sprint_response_json['values'][0]['id'];  
    puts "sprint_id=#{sprint_id}"
	
    sprint_uri = URI("#{$JIRA_URL}/rest/agile/1.0/sprint/#{sprint_id}")		  
    Net::HTTP.start(sprint_uri.host, sprint_uri.port,
  	                :use_ssl => sprint_uri.scheme == 'https', 
  	                :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

      request = Net::HTTP::Get.new sprint_uri.request_uri
	  request.basic_auth $JIRA_USERNAME, $JIRA_PASSWORD
	  sprint_response = http.request request
      sprint_response_json = JSON.parse(sprint_response.body)

	  sprint_name = sprint_response_json['name'];
      start_date = Date.parse(sprint_response_json['startDate'])
      str_start_date = start_date.strftime("%b %d %Y")  
	  end_date = Date.parse(sprint_response_json['endDate'])
      str_end_date = end_date.strftime("%b %d %Y")  
	  remaining_days = (end_date - $today).to_i
    end		 

    issues_uri = URI("#{$JIRA_URL}/rest/agile/1.0/sprint/#{sprint_id}/issue")		  
    Net::HTTP.start(issues_uri.host, issues_uri.port, 
  	                :use_ssl => issues_uri.scheme == 'https', 
  	                :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

      request = Net::HTTP::Get.new issues_uri.request_uri
	  request.basic_auth $JIRA_USERNAME, $JIRA_PASSWORD
	  issues_response = http.request request
	  issues_response_json = JSON.parse(issues_response.body)

	  issues = issues_response_json['issues'];
	  if issues.length != 0 then
	    issues.each { |issue|
	      fields = issue['fields'];
	      $tasks_total = $tasks_total + 1
	      if (fields['resolutiondate'] && fields['resolutiondate'].length > 0)
		    $tasks_done = $tasks_done + 1
		  end

		  if (!fields['resolutiondate'] || fields['resolutiondate'].length == 0)
		    $tasks_left = $tasks_left + 1
		  end
	    }
	  end
    end

  end

  
  $sprint_details[0] = { label: 'Name', value: sprint_name }
  $sprint_details[1] = { label: 'Start Date', value: str_start_date }
  $sprint_details[2] = { label: 'End Date', value: str_end_date }
  $sprint_details[3] = { label: 'Days Left', value: remaining_days }

  puts "sprint name=#{sprint_name}"
  puts "sprint startdate=#{str_start_date}"
  puts "sprint enddate=#{str_end_date}"
  puts "today=#{$today}"
  puts "remaining_days=#{remaining_days}"	
  puts "Tasks Completed: #{$tasks_done}"
  puts "Tasks Remaining: #{$tasks_left}"
  puts "Tasks Total: #{$tasks_total}"
end


SCHEDULER.every '30m', :first_in => 0 do |job|
  puts 'Starting the job gysp_jira.rb..'
  fetch_jira_data

  send_event('gysp_sprint_details_id', { items: $sprint_details })
  send_event('gysp_jira_tasks_total_id', { text: $tasks_total })
  send_event('gysp_jira_tasks_done_id', { text: $tasks_done })
  send_event('gysp_jira_tasks_left_id', { text: $tasks_left })
  puts 'Completed the job gysp_jira.rb.'
end
