require "sinatra/base"
require "sinatra/json"
require "pry"

DB = {}

class Coloson < Sinatra::Base

  attr_reader :numberwang

  def initialize
    @numberwang = rand(1..11)
    super
  end

  def self.reset_database
    DB.clear
  end

  def reset_numberwang
    @numberwang = rand(1..11)
    DB["numberwang"].clear
  end

  set :show_exceptions, false
  error do |e|
    raise e
  end

  get "/numbers/evens" do
    unless DB["evens"]
      DB["evens"] = []
    end
      json DB["evens"]
  end

  post "/numbers/evens" do
    num_to_add = params["number"]
    if num_to_add == num_to_add.to_i.to_s
      if DB["evens"]
        DB["evens"].push(num_to_add.to_i)
        200
      else
        DB["evens"] = [num_to_add.to_i]
        200
      end
    else
      body json(status: "error", error: "Invalid number: #{num_to_add}")
      422
    end
  end

  get "/numbers/odds" do
    unless DB["odds"]
      DB["odds"] = []
    end
      json DB["odds"]
  end

  post "/numbers/odds" do
    num_to_add = params["number"]
    if num_to_add == num_to_add.to_i.to_s
      if DB["odds"]
        DB["odds"].push(num_to_add.to_i)
        200
      else
        DB["odds"] = [num_to_add.to_i]
        200
      end
    else
      body json(status: "error", error: "Invalid number: #{num_to_add}")
      422
    end
  end

  delete "/numbers/odds" do
    num_to_delete = params["number"]
    if num_to_delete == num_to_delete.to_i.to_s
      DB["odds"].delete(num_to_delete.to_i)
      200
    else
      body json(status: "error", error: "Invalid number: #{num_to_add}")
      422
    end
  end

  post "/numbers/primes" do
    num_to_add = params["number"]
    if num_to_add == num_to_add.to_i.to_s
      if DB["primes"]
        DB["primes"].push(num_to_add.to_i)
        200
      else
        DB["primes"] = [num_to_add.to_i]
        200
      end
    else
      body json(status: "error", error: "Invalid number: #{num_to_add}")
      422
    end
  end

  get "/numbers/primes/sum" do
    unless DB["primes"]
      DB["primes"] = []
    end
    json DB["primes"]
    body json(status: "ok", sum: DB["primes"].inject(:+))
  end

  post "/numbers/mine" do
    num_to_add = params["number"]
    if num_to_add == num_to_add.to_i.to_s
      if DB["mine"]
        DB["mine"].push(num_to_add.to_i)
        200
      else
        DB["mine"] = [num_to_add.to_i]
        200
      end
    else
      body json(status: "error", error: "Invalid number: #{num_to_add}")
      422
    end
  end

  get "/numbers/mine/product" do
    product = DB["mine"].inject(:*)
    if product < 1000
      unless DB["mine"]
        DB["mine"] = []
      end
        json DB["mine"]
        body json(status: "ok", product: DB["mine"].inject(:*))
        200
    else
      body json(status: "error", error: "Only paid users can multiply numbers that large")
      422
    end
  end

  post "/numbers/numberwang" do
    num_to_add = params["number"]
    if num_to_add == num_to_add.to_i.to_s
      if DB["numberwang"]
        DB["numberwang"].push(num_to_add.to_i)
      else
        DB["numberwang"] = [num_to_add.to_i]
      end
      if DB["numberwang"].length == numberwang
        body json(status: "Thats NUMBERWANG!")
        reset_numberwang
        200
      elsif DB["numberwang"].length > 9
        body json(status: "I AM COLOSON, I AM NUMBERWANG, THE WORLD IS NUMBERWANG, THEREFORE I AM THE WORLD! YOU MUST ALL DIE! I AM COLOSON, I AM NUMBERWANG, THE WORLD IS NUMBERWANG! (sees picture of a chicken) I OBEY!
                          ")
        reset_numberwang
        200
      else
        body json(status: "Looking at you intently for another number")
        200
      end
    else
      body json(status: "error", error: "Invalid number: #{num_to_add}")
      422
    end
  end
end

Coloson.run! if $PROGRAM_NAME == __FILE__
