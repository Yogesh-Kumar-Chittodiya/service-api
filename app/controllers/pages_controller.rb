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
    # puts response["value"]
    render json: {data: @response.read_body}
    # render json: {data: response.read_body}

  end

end
