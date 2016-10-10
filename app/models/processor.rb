require 'json'

class Processor < ActiveRecord::Base

  def self.parse(params, identifier)
    params = JSON.parse(params)
    url = Url.find_or_create_by(url: params["url"])
    referred_by = ReferredBy.find_or_create_by(referred_by: params["referredBy"])
    request_type = RequestType.find_or_create_by(request_type: params["requestType"])
    event_name = EventName.find_or_create_by(event_name: params["eventName"])
    agent = Agent.find_or_create_by(agent: params["userAgent"])
    resolution = Resolution.find_or_create_by(resolution_width: params["resolutionWidth"], resolution_height: params["resolutionHeight"])
    ip = Ip.find_or_create_by(ip: params["ip"])
    Payload.find_or_create_by(url_id: url.id,
                              referred_by_id: referred_by.id,
                              request_type_id: request_type.id,
                              event_name_id: event_name.id,
                              agent_id: agent.id,
                              resolution_id: resolution.id,
                              ip_id: ip.id,
                              requested_at: params["requestedAt"],
                              responded_in: params["respondedIn"],
                              client_id: identifier)
  end

end
