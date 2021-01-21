class VideosController < ApplicationController
  before_action :require_video, only: [:show]

  def index
    if params[:query]
      data = VideoWrapper.search(params[:query])
    else
      data = Video.all
    end

    render status: :ok, json: data
  end

  def show
    render(
      status: :ok,
      json: @video.as_json(
        only: [:title, :overview, :release_date, :inventory],
        methods: [:available_inventory]
        )
      )
  end

  #FRONT-END:
  # find the movie by external id
  # submit/add to library
  # in App: api.post 
  # create a video by finding movie by external id?
  # if that doesn't exist, save to library
  # else render a message that it already exists

  # def create
  #   movie = Video.new(require_video)
  #
  #   if movie.save
  #     render json: video.as_json(only: [:title]), status: :created
  #     # add to library?
  #     return
  #   else
  #     render json: {
  #         errors: video.errors.messages
  #     }, status: :bad_request
  #     return
  #   end
  # end

  def add_to_library
    # find movie_id
    # data = VideoWrapper.construct_video(params[:external_id])
    #
    #
    # if data.nil?
    #   render not_found message
    # else
    #
    #
    # if we found the movie_id
    #   check to see if it exits
    #   if not, add to library
    # else
    #   display message
    # end
    #
    # if param[:title]
    #   data = vi
    # end
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      render(
          status: :ok,
          json: @video.as_json(
              only: [:title, :overview, :release_date, :external_id, :image_url],
          )
      )
    else
       render json: {ok: false, cause: "validation errors", errors: @video.errors}, status: :bad_request
    end
  end

  private

  def video_params
    return params.permit(:external_id, :overview, :image_url, :release_date, :title )
  end

  def require_video
    @video = Video.find_by(title: params[:title])
    unless @video
      render status: :not_found, json: { errors: { title: ["No video with title #{params["title"]}"] } }
    end
  end
end
