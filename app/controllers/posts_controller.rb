class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_gender, only: [:index]

  # GET /posts
  # GET /posts.json
  def index
    @post = Post.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def filter
    case params[:filter_select]
      when "0"
        # gender and location filtering, default radius is 10 km
        Post.filter_by_gender_and_location(user_id: session[:user_id], radius: params[:radius], gender_pref: params[:gender_pref], user_lat: params[:user_lat], user_lon: params[:user_lon])
      when "1"
        # pace filtering with gender and location
        Post.filter_by_pace(user_id: session[:user_id], radius: params[:radius], gender_pref: params[:gender_pref], user_lat: params[:user_lat], user_lon: params[:user_lon], pace: params[:pace])
      when "2"
        # age filtering with gender and location
        Post.filter_by_age(user_id: session[:user_id], radius: params[:radius], gender_pref: params[:gender_pref], user_lat: params[:user_lat], user_lon: params[:user_lon], age: params[:age_pref])
      when "3"
        # time filtering with gender and location
        start_date = params[:start_time][:day] + '/' + params[:start_time][:month] + '/' + params[:start_time][:year]
        start_hour = params[:start_time][:hour] + ':' + params[:start_time][:minute]
        start_time = start_date + " " + start_hour

        end_date = params[:end_time][:day] + '/' + params[:end_time][:month] + '/' + params[:end_time][:year]
        end_hour = params[:end_time][:hour] + ':' + params[:start_time][:minute]
        end_time = end_date + " " + end_hour

        starting = Time.zone.parse(start_time).utc
        ending = Time.zone.parse(end_time).utc

        Post.filter_by_time(user_id: session[:user_id], radius: params[:radius], gender_pref: params[:gender_pref], user_lat: params[:user_lat], user_lon: params[:user_lon], start_time: starting, end_time: ending)
    end

    respond_to do |format|
      format.js
    end
  end
  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:circle_id, :creator_id, :time, :latitude, :longitude, :pace, :notes, :complete, :min_amt, :age_pref, :gender_pref, :max_runners, :min_distance, :address)
    end

    def check_gender
      if !(params.has_key?(:gender_pref) && params.has_key?(:radius))
        params[:gender_pref] = 0
        # default radius from user is 10 km
        params[:radius] = 10
      end
      if params[:gender_pref] != 0 && params[:gender_pref] != 3
        if user.gender != inputs[:gender_pref]
          flash[:notice] = "User cannot view opposite gender posts"
          redirect_to(:controller => 'posts', :action => 'index')
          return false
        end
      end
    end
end
