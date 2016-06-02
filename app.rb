require "sinatra/base"
require "sinatra/json"
require "pry"

DB = {}

class Coloson < Sinatra::Base

  def self.reset_database
    DB.clear
  end

  # def reset_numberwang
  #   DB["numberwang"].clear
  # end
  #
  # set :show_exceptions, false
  # error do |e|
  #   raise e
  # end
  #
  # get "/numbers/evens" do
  #   unless DB["evens"]
  #     DB["evens"] = []
  #   end
  #     json DB["evens"]
  # end
  #
  # post "/numbers/evens" do
  #   num_to_add = params["number"]
  #   if num_to_add == num_to_add.to_i.to_s
  #     if DB["evens"]
  #       DB["evens"].push(num_to_add.to_i)
  #       200
  #     else
  #       DB["evens"] = [num_to_add.to_i]
  #       200
  #     end
  #   else
  #     body json(status: "error", error: "Invalid number: #{num_to_add}")
  #     422
  #   end
  # end
  #
  # get "/numbers/odds" do
  #   unless DB["odds"]
  #     DB["odds"] = []
  #   end
  #     json DB["odds"]
  # end
  #
  # post "/numbers/odds" do
  #   num_to_add = params["number"]
  #   if num_to_add == num_to_add.to_i.to_s
  #     if DB["odds"]
  #       DB["odds"].push(num_to_add.to_i)
  #       200
  #     else
  #       DB["odds"] = [num_to_add.to_i]
  #       200
  #     end
  #   else
  #     body json(status: "error", error: "Invalid number: #{num_to_add}")
  #     422
  #   end
  # end
  #
  # delete "/numbers/odds" do
  #   num_to_delete = params["number"]
  #   if num_to_delete == num_to_delete.to_i.to_s
  #     DB["odds"].delete(num_to_delete.to_i)
  #     200
  #   else
  #     body json(status: "error", error: "Invalid number: #{num_to_add}")
  #     422
  #   end
  # end
  #
  # post "/numbers/primes" do
  #   num_to_add = params["number"]
  #   if num_to_add == num_to_add.to_i.to_s
  #     if DB["primes"]
  #       DB["primes"].push(num_to_add.to_i)
  #       200
  #     else
  #       DB["primes"] = [num_to_add.to_i]
  #       200
  #     end
  #   else
  #     body json(status: "error", error: "Invalid number: #{num_to_add}")
  #     422
  #   end
  # end
  #
  # get "/numbers/primes/sum" do
  #   unless DB["primes"]
  #     DB["primes"] = []
  #   end
  #   json DB["primes"]
  #   body json(status: "ok", sum: DB["primes"].inject(:+))
  # end
  #
  # post "/numbers/mine" do
  #   num_to_add = params["number"]
  #   if num_to_add == num_to_add.to_i.to_s
  #     if DB["mine"]
  #       DB["mine"].push(num_to_add.to_i)
  #       200
  #     else
  #       DB["mine"] = [num_to_add.to_i]
  #       200
  #     end
  #   else
  #     body json(status: "error", error: "Invalid number: #{num_to_add}")
  #     422
  #   end
  # end
  #
  # get "/numbers/mine/product" do
  #   product = DB["mine"].inject(:*)
  #   if product < 1000
  #     unless DB["mine"]
  #       DB["mine"] = []
  #     end
  #       json DB["mine"]
  #       body json(status: "ok", product: DB["mine"].inject(:*))
  #       200
  #   else
  #     body json(status: "error", error: "Only paid users can multiply numbers that large")
  #     422
  #   end
  # end
  #
  post "/numbers/numberwang" do
    num_to_add = params["number"]
    if num_to_add == num_to_add.to_i.to_s
      if DB["numberwang"]
        DB["numberwang"].push(num_to_add.to_i)
      else
        DB["numberwang"] = [num_to_add.to_i]
      end
      if rand(1..5) ==  rand(1..5)
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

  post "/numbers/:site" do
    num_to_add = params["number"]
    if num_to_add == num_to_add.to_i.to_s
      if DB[params['site']]
        DB[params['site']].push(num_to_add.to_i)
        200
      else
        DB[params['site']] = [num_to_add.to_i]
        200
      end
    else
      body json(status: "error", error: "Invalid number: #{num_to_add}")
      422
    end
  end

  get "/numbers/:site" do
    unless DB[params['site']]
      DB[params['site']] = []
    end
      json DB[params['site']]
  end

  get "/numbers/:site/product" do
    product = DB[params['site']].inject(:*)
    if product < 1000
      unless DB[params['site']]
        DB[params['site']] = []
      end
        json DB[params['site']]
        body json(status: "ok", product: DB[params['site']].inject(:*))
        200
    else
      body json(status: "error", error: "Only paid users can multiply numbers that large")
      422
    end
  end

  get "/numbers/:site/sum" do
    unless DB[params['site']]
      DB[params['site']] = []
    end
    json DB[params['site']]
    body json(status: "ok", sum: DB[params['site']].inject(:+))
  end

  delete "/numbers/:site" do
    num_to_delete = params["number"]
    if num_to_delete == num_to_delete.to_i.to_s
      DB[params['site']].delete(num_to_delete.to_i)
      200
    else
      body json(status: "error", error: "Invalid number: #{num_to_add}")
      422
    end
  end
end

Coloson.run! if $PROGRAM_NAME == __FILE__
