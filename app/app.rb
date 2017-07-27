ENV['RACK_ENV'] ||= 'development'
require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'models/user'
require_relative 'models/link'
require_relative 'models/tag'
require_relative '../data_mapper_setup'
require 'sinatra/base'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(:email => params[:email], :password => params[:password])
    session[:user_id] = user.id
    redirect '/links'
  end

  get '/links' do
    @user = current_user
    @links = Link.all
    erb :'links/index', :layout => :layout
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tags].downcase.split.each do |tag|
      link.tags << Tag.first_or_create(name: tag)
    end
    link.save
    redirect '/links'
  end


  get '/tags/:tag' do
    @tag = Tag.all(:name => params[:tag])
    erb :'tags/tags'
  end

run! if app_file == $0

end
