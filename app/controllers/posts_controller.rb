class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_gender, only: [:index]
  before_action :sanitize_params, only: [:create, :filter]
  before_action :format_time, only: [:create]

  # GET /posts
  # GET /posts.json
  def index
    @post = Post.new
  end

  # TODO: Write tests around refactoring
  def filter
    params.merge!(user_id: session[:user_id])
    case params[:filter_select]
      when gender_and_location_filter
        @posts = Post.filter_by_gender(post_filter_params).filter_by_location(post_filter_params)
      when pace_filter
        @posts = Post.filter_by_pace(post_filter_params)
      when age_filter
        @posts = Post.filter_by_age(post_filter_params)
      when time_filter
        @posts = Post.filter_by_time(post_filter_params)
      when commitment_filter
        @posts = Post.filter_by_commitment(post_filter_params)
    end

    render json: @posts, each_serializer: PostSerializer
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
    @post = Post.create(post_params)
    render json: @post, serializer: PostSerializer
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

  def get_form
    @post = Post.new
    render :partial => "/posts/form.html.erb"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:circle_id, :organizer_id, :time, :pace, :notes, :complete, :min_amt, :age_pref, :gender_pref, :max_runners, :min_distance, :address)
    end

    def post_filter_params
      params.permit(:user_id, :radius, :gender_pref, :user_lat, :user_lon, :pace, :age_pref, :min_amt, start_time: [:year, :month, :day, :hour, :minute], end_time: [:year, :month, :day, :hour, :minute])
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

    def format_time
      date = params[:day][:day] + '/' + params[:month_select] + '/' + params[:year][:year]
      hour = params[:date][:hour] + ':' + params[:date][:minute]
      time = date + " " + hour
      params[:post][:time] = Time.zone.parse(time).utc
    end

    def gender_and_location_filter
      "0"
    end

    def pace_filter
      "1"
    end

    def age_filter
      "2"
    end

    def time_filter
      "3"
    end

    def commitment_filter
      "4"
    end

    def hash_strings_to_num(h, search)
      if h.fetch(search, false)
        if h[search].include? '.'
          h[search] = h[search].to_f
          return true
        else
          h[search] = h[search].to_i
          return true
        end
      end

      h.keys.each do |k|
        stop_search = hash_strings_to_num(h[k], search) if h[k].is_a? Hash
        return stop_search if stop_search
      end

      true
    end

    def sanitize_params
      hash_strings_to_num(params, :radius)
      hash_strings_to_num(params, :age_pref)
      hash_strings_to_num(params, :gender_pref)
      hash_strings_to_num(params, :user_lat)
      hash_strings_to_num(params, :user_lon)
      hash_strings_to_num(params, :pace)
    end

end
