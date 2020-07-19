require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

 get '/' do	
      redirect to '/articles'
    end

    get '/articles' do
      @articles = Article.all
      erb :index
    end

    get '/articles/new' do
      @article = Article.new
      erb :new
    end

    post '/articles' do
      @article = Article.create(title: params[:title], content: params[:content])
      redirect to "/articles/#{@article.id}"
    end

    get '/articles/:id' do
      @article = Article.find(params[:id])
      erb :show
    end

    get '/articles/:id/edit' do
      @article = Article.find(params[:id])
      erb :edit
    end


    patch "/articles/:id" do
      @article = Article.find(params[:id])
      # @article.update(title: params[:title], content: params[:content])
      @article.update(params[:article])
      redirect to "/articles/#{ @article.id }"
    end


    delete '/posts/:id/delete' do
    @post = Post.find(params["id"])
    @post.destroy
    erb :delete
    end
  end