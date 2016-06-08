API_URL = "https://www.slideshare.net/api/2/get_slideshow"

class Slideshare
  attr_reader :show_id

  def initialize(attributes)
    @id = attributes["id"]
  end

  def self.find(id)

  end
end
