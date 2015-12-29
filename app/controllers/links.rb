class BookmarkManager < Sinatra::Base
  get '/' do
    'Welcome to your Bookmark Manager'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:Name])
    params[:tags].split.each do |tag_name|
      link.tags << Tag.first_or_create(name: tag_name)
    end
    link.save
    redirect '/links'
  end

  get '/links/new' do
    erb :'/links/new'
  end
end
