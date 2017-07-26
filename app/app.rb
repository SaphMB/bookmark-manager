ENV['RACK_ENV'] ||= 'development'
require_relative 'models/link'
require_relative 'models/tag'
require_relative '../data_mapper_setup'
require 'sinatra/base'

class BookmarkManager < Sinatra::Base

  helpers do

    def create_new_tags(tags, link)
      tags.each do |tag|
        associate_tag =
        if Tag.all(:name => tag).empty?
          Tag.create(name: tag)
        else
          Tag.first(:name => tag)
        end
        LinkTag.create(:link => link, :tag => associate_tag)
      end
    end

  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    create_new_tags(params[:tags].split, link)
    # tag = Tag.create(name: params[:tags])
    #
    # LinkTag.create(:link => link, :tag => tag)
    redirect '/links'
  end


  get '/tags/:tag' do
    @tag = Tag.all(:name => params[:tag])
    erb :'tags/tags'
  end

run! if app_file == $0

end
