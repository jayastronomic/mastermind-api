require "httparty"

class RandGenService
  URL = "https://www.random.org/integers/"

  def get_random_number
    output = ""
    params = {
      num: 4,
      min: 0,
      max: 7,
      col: 1,
      base: 10,
      format: "plain",
      rnd: "new"
    }
    response = HTTParty.get(URL, query: params)
    random_number = response.body
    random_number.each_line do |line|
      output += line.strip
    end
    output
  end
end
