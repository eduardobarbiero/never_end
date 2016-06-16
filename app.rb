require 'sinatra'
require_relative 'kernel'

get '/' do
  @list = KillShit.list_process
  erb :index
end

post '/kill/:id' do
  begin
    KillShit.kill_process params[:id]
  rescue => e
    p "erro:" + e.to_s
  ensure
    @list = KillShit.list_process
    redirect '/'
  end
end
