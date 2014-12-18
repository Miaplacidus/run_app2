class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_gender, only: [:index]

  # GET /posts
  # GET /posts.json
  def index
    @post = Post.new
  end

  # TODO: Write tests around refactoring
  # TODO: Break the case into methods
  def filter
    params.merge!(user_id: session[:user_id])
    case params[:filter_select]
      when "0"
        # gender and location filtering, default radius is 10 km
        @posts = Post.filter_by_gender(post_filter_params).filter_by_location(post_filter_params)
      when "1"
        # pace filtering with gender and location
        @posts = Post.filter_by_pace(post_filter_params)
      when "2"
        # age filtering with gender and location
        @posts = Post.filter_by_age(post_filter_params)
      when "3"
        # time filtering with gender and location
        start_date = params[:start_time][:day] + '/' + params[:start_time][:month] + '/' + params[:start_time][:year]
        start_hour = params[:start_time][:hour] + ':' + params[:start_time][:minute]
        start_time = start_date + " " + start_hour

        end_date = params[:end_time][:day] + '/' + params[:end_time][:month] + '/' + params[:end_time][:year]
        end_hour = params[:end_time][:hour] + ':' + params[:start_time][:minute]
        end_time = end_date + " " + end_hour

        params[:start_time] = Time.zone.parse(start_time).utc
        params[:end_time] = Time.zone.parse(end_time).utc

        @posts = Post.filter_by_time(post_filter_params)
    end

    render json: @posts, each_serializer: PostSerializer
  end

  def time
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
      params.require(:post).permit(:circle_id, :creator_id, :latitude, :longitude, :pace, :notes, :complete, :min_amt, :age_pref, :gender_pref, :max_runners, :min_distance, :address)
    end

    def post_filter_params
      params.permit(:user_id, :radius, :gender_pref, :user_lat, :user_lon, :start_time, :end_time, :pace, :age)
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
