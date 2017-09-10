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

$GYSP_NODE_PET_NAMES_MAP = Hash['web.galaxy.net' => 'web', 'services.galaxy.net' => 'services', 'database.galaxy.net' => 'database'] 
$GYSP_NODES_MAP = Hash.new

def get_host_color(state) 
  color = 'green'
  case state 
    when '0'
      color = 'green'
    when '1'
      color = 'red'
    else
      color = 'amber'
  end
  return color
end

def get_service_color(state) 
  color = 'green'
  case state 
    when '0'
      color = 'green'
    when '2' 
      color = 'red'
    else
      color = 'amber'
  end
  return color
end

def translate_host_state(state) 
  status = 'Ok'
  case state 
    when '0'
      status = 'Up'
    when '1'
      status = 'Down'
    else
      status = 'Unknown'
  end
  return status
end

def translate_service_state(state) 
  status = 'Ok'
  case state 
    when '0'
      status = 'Ok'
    when '2' 
      status = 'Critical'
    else
      status = 'Warning'
  end
  return status
end

def build_nodes(host_status_array)
  host_status_array.each { |h|
    host_name = h['display_name']
    pet_name = $GYSP_NODE_PET_NAMES_MAP[host_name]
    if $GYSP_NODE_PET_NAMES_MAP.has_key? host_name then
      node = Hash.new
      node['host_name'] = host_name 
      node['pet_name'] = pet_name
      node['last_updated'] = h['status_update_time'] 
      node['host_check'] = translate_host_state(h['current_state'])    
      node['color'] = get_host_color(h['current_state'])
      $GYSP_NODES_MAP[pet_name] = node
    end
  }
end

def build_nodes_with_services(service_status_array)
  service_status_array.each { |s|
  host_name = s['host_name']
  pet_name = $GYSP_NODE_PET_NAMES_MAP[host_name]
  if $GYSP_NODE_PET_NAMES_MAP.has_key? host_name && then
    node = $GYSP_NODES_MAP[pet_name] 
    if node['host_check'] != 'Down' then
      node['current_state'])
    $GYSP_NODES_MAP[pet_name] = node
    end
   }
	      85 end


def print_nodes
  i=0
  $GYSP_NODES_MAP.each do |outerkey, outervalue|
    i = i + 1
    puts "#{i}.#{outerkey}: "
    outervalue.each do |key, value|
      puts "#{key}: #{value}"
    end
    puts
  end
end

def fetch_nagios_data
  Net::HTTP.start($host_status_uri.host, $host_status_uri.port) do |http| 
    request = Net::HTTP::Get.new $host_status_uri.request_uri

    host_status_response = http.request request
    host_status_response_json = JSON.parse(host_status_response.body)

    host_status_array = host_status_response_json['hoststatuslist']['hoststatus']
    puts("No of hosts=#{host_status_array.length}")
    
    if host_status_array.length != 0 then
      build_nodes(host_status_array)
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
   #     puts("#{host_name}, #{display_name}, #{status_update_time}, #{current_state}")
      }
    end
    puts("############################################################################################")
   end
	      
end

fetch_nagios_data
print_nodes
