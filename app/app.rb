ENV['RACK_ENV'] ||= 'development'
require_relative 'models/link'
require_relative 'models/tag'
require_relative '../data_mapper_setup'
require 'sinatra/base'

class BookmarkManager < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    tag = Tag.create(name: params[:tag])
    link = Link.create(url: params[:url], title: params[:title])
    LinkTag.create(:link => link, :tag => tag)
    redirect '/links'
  end

run! if app_file == $0

end
