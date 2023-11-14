require "dotenv"
Dotenv.load(".env")

require "openai"
require "sinatra"

set :port, 4000

get "/" do
  erb :index
end

post "/" do
  client = OpenAI::Client.new(access_token: ENV["OPEN_AI_ACCESS_TOKEN"])

  @reply = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: params[:prompt] }],
      temperature: 0.5
    }
  ).dig("choices", 0, "message", "content")

  erb :index
end
