require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"
require 'yaml'

before do
	@users = YAML.load_file("users.yaml")
end

get "/" do
	@names = @users.keys

	erb :home
end

get "/:username" do
	@username = params[:username].to_sym
	@info = @users[@username]

	erb :user
end

helpers do
	def count_interests
		total = 0
		each_user { |usr_name, _, interest| total += interest.size }
		total
	end

	def each_user
		@users.keys.each do |usr_name|
			email = @users[usr_name][:email]
			interests = @users[usr_name][:interests]
			yield(usr_name, email, interests) if block_given?
		end
	end
end