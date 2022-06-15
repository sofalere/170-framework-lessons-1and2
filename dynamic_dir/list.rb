require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
	@files = Dir.glob("public/*").map do |filepath|
		File.basename(filepath)
	end
	.sort

	@files = @files.reverse if params[:sort] == "descending"

	erb :list_views
end