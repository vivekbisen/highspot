class User
  attr_reader :id, :name

  def initialize(params)
    @params = params
    @id = params["id"]
    @name = params["name"]
  end

  def to_h
    @params
  end
end
