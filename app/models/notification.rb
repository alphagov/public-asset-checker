class Notification
  attr_reader :id, :url
  attr_accessor :color, :title, :value

  def initialize(id, url)
    @id = id
    @url = url
  end

  def banner
    "<#{ENV['PRODUCTION_URL']}/public_assets/#{id}|Asset check>: <#{url}|#{url}>"
  end

  def priority_color(priority)
    case priority
    when "needs-attention"
      "#d4351c"
    when "same"
      "#00703c"
    else
      "#1d70b8"
    end
  end

  def message
    {
      "attachments": [
        {
          "fallback": banner,
          "pretext": banner,
          "color": priority_color(color),
          "fields": [
            {
              "title": title,
              "value": value,
              "short": false,
            },
          ],
        },
      ],
    }
  end
end
