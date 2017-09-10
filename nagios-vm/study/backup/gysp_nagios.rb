require 'json'
require 'net/http'
require 'openssl'
require 'date'

#curl -XGET "http://mynagios/nagiosxi/api/v1/objects/hoststatus?apikey=BZpYdTJ8DrmMBHHbpcHZbe3RV5vGJtLgsauZju7WfMIQJGhoRfIiMKpH5ej4Lkkd&pretty=1"

$API_KEY="BZpYdTJ8DrmMBHHbpcHZbe3RV5vGJtLgsauZju7WfMIQJGhoRfIiMKpH5ej4Lkkd"
$NAGIOS_URL = "http://mynagios"
$HOST_STATUS_URL="#{$NAGIOS_URL}/nagiosxi/api/v1/objects/hoststatus?pretty=1&apikey=#{$API_KEY}"
$SERVICE_STATUS_URL="#{$NAGIOS_URL}/nagiosxi/api/v1/objects/servicestatus?pretty=1&apikey=#{$API_KEY}"
$host_status_uri = URI($HOST_STATUS_URL);
$service_status_uri = URI($SERVICE_STATUS_URL);

$today = Date.today

def fetch_nagios_data
  Net::HTTP.start($host_status_uri.host, $host_status_uri.port) do |http| 
    request = Net::HTTP::Get.new $host_status_uri.request_uri

    host_status_response = http.request request
    host_status_response_json = JSON.parse(host_status_response.body)

    host_status_array = host_status_response_json['hoststatuslist']['hoststatus']
    puts("No of hosts=#{host_status_array.length}")
    
    if host_status_array.length != 0 then
      host_status_array.each { |h|
        display_name = h['display_name']
        status_update_time = h['status_update_time']
        current_state = h['current_state']
	puts("#{display_name}, #{status_update_time}, #{current_state}")
      }
     end
     puts("")
     puts("############################################################################################")
  end

  Net::HTTP.start($service_status_uri.host, $service_status_uri.port) do |http| 
    request = Net::HTTP::Get.new $service_status_uri.request_uri
	      
    service_status_response = http.request request
    service_status_response_json = JSON.parse(service_status_response.body)
    
    service_status_array = service_status_response_json['servicestatuslist']['servicestatus']
    puts("No of services=#{service_status_array.length}")
	                         
    if service_status_array.length != 0 then
      service_status_array.each { |s|
        host_name = s['host_name']
        display_name = s['display_name']
        status_update_time = s['status_update_time']
        current_state = s['current_state']
        puts("#{host_name}, #{display_name}, #{status_update_time}, #{current_state}")
      }
    end
    puts("############################################################################################")
   end
	      
end

fetch_nagios_data

