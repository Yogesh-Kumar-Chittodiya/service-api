class PagesController < ApplicationController

  def servicenow
    require "uri"
    require "json"
    # require "net/http"
    require 'net/https'

    url = URI("https://dev163077.service-now.com/api/now/table/incident?sysparm_limit=1")

    # uri = URI.parse("https://dev163077.service-now.com/api/now/table/incident?sysparm_limit=10")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    # https.ssl_version = 'SSLv3'
    # https.get(uri.request_uri)

    request = Net::HTTP::Get.new(url)
    request["Content-Type"] = "application/json"
    request["Accept"] = "application/json"
    request["X-UserToken"] = "0f0afa569730311057517076f053afa205ffe7082d514a67d5a214a54dac2f88aa9832e7"
    request["X-TransactionSource"] = "Interface=Web,Interface-Type=Classic Environment,Interface-Name=Unified Navigation App"
    request["Authorization"] = "Basic YWRtaW46bEFJPXk1UXN5RUAx"
    request["Cookie"] = "BIGipServerpool_dev163077=310400778.51776.0000; JSESSIONID=407EF1AD2CBFBAAF4FBB944C9DA1D9D7; glide_user_activity=U0N2M18xOlB1eHF3cis1M09tMjhWcWdLK2lGanVyeElKUVg3MXh1N0ZUa3RqRk9QSjg9Ok1wSTFwVkFXaXhzb3dGVy82MzNUS1NObnlkT0hPazJOWmwzNlpPME1aZmM9; glide_user_route=glide.b7b293365daf342e41f3feca3ed8e9bb"

    @response = https.request(request)
    # puts response.read_body
    # @response =JSON.parse(@response.read_body)
    # render json: {data: @response}
    render json: {data: @response.read_body}

  end

  def view
    require "uri"
    require "net/http"

    url = URI("https://dev163077.service-now.com/api/now/table/incident?sysparm_fields=number%2Csys_created_on%2Csys_domain%2Cstate%2Csys_created_by%2Cclosed_at%2Cimpact%2Cactive%2Cpriority%2Cu_email&sysparm_limit=5")
    
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Basic YWRtaW46bEFJPXk1UXN5RUAx"
    request["Cookie"] = "BIGipServerpool_dev163077=310400778.51776.0000; JSESSIONID=AB15DFDD389F719EDD38519AE842B16D; glide_session_store=801558D09711311057517076F053AF3A; glide_user_route=glide.b7b293365daf342e41f3feca3ed8e9bb"

    response = https.request(request)
    
    # puts response.read_body
    # render json: {data: response.read_body}

    @res = JSON.parse(response.read_body)

    # @result=@res["result"][1]["number"]
    # render json: {Incident_Number: @result}

    # render json: {data: @res}
    
    # render json: @res["result"][0]["sys_domain"]["link"]

#
    # for i in 0..(@res["result"].count-1)
    i=4
    @a=@res["result"][i]["number"]
      if(ServicenowApi.find_by(params[@a]))
        render json: {Count: @res["result"].count, Number: @res["result"][i]["number"], Email: @res["result"][i]["u_email"], Impact: @res["result"][i]["u_impact"], Caller_id: @res["result"][i]["u_caller_id"], short_description: @res["result"][i]["u_short_description"], Assigned_to: @res["result"][i]["u_assigned_to"], Active: @res["result"][i]["active"], State: @res["result"][i]["state"], Priority: @res["result"][i]["priority"]}
      else 
        @ser=ServicenowApi.new(number: @res["result"][i]["number"], email: @res["result"][i]["u_email"], impact: @res["result"][i]["u_impact"], caller_id: @res["result"][i]["u_caller_id"], short_description: @res["result"][i]["u_short_description"], assigned_to: @res["result"][i]["u_assigned_to"], active: @res["result"][i]["active"], state: @res["result"][i]["state"], priority: @res["result"][i]["priority"])
        if(@ser.save!)
          render json: {data: @res["result"][i], status: "created successfully."}
        else
          render json: {data: "data has not saved in the database."}
        end
        
      # end
      # puts "data has been inserted in the database"
    end
#

    #table desc
    # rails g model servicenow-api number:string email:string impact:integer caller_id:string short_description:string assigned_to:string active:integer state:integer priority:integer

    # render json: {data: response.read_body}

      # response.each do |res| 
      #   render json: {data: res.read_body}
      # end

  end


end
