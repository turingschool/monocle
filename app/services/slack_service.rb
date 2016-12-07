module SlackService
  def self.authenticate(params)
    return false if params["error"] || params["code"].nil?
    user_info = fetch_info_via_code(params["code"])
    User.create_from_slack(user_info)
  end

  def self.sign_in_uri
    "https://slack.com/oauth/authorize?" +
      "scope=identity.basic,identity.team,identity.avatar&" +
      "client_id=#{ENV['slack_client_id']}&" +
      "redirect_uri=#{redirect_uri}"
  end

  private
    def self.redirect_uri
      if ENV["RAILS_ENV"].in?(["test", "development"])
        "http%3A%2F%2F0.0.0.0%3A3000%2Fauth%2Fslack%2Fcallback"
      else
        "https%3A%2F%2Fturingmonocle%2Dstaging.herokuapp.com%2Fauth%2Fslack%2Fcallback"
      end
    end

    def self.conn
      Faraday.new(:url => "https://slack.com") do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
        faraday.basic_auth(ENV['slack_client_id'], ENV['slack_client_secret'])
      end
    end

    def self.fetch_info_via_code(code)
      response = conn.get do |req|
        req.url "/api/oauth.access?redirect_uri=#{redirect_uri}"
        req.params["code"] = code
      end
      JSON.parse(response.body)
    end
end
