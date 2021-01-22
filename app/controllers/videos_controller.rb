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
    return params.permit(:external_id, :overview, :image_url, :release_date, :title, :inventory)
  end

  def require_video
    @video = Video.find_by(title: params[:title])
    unless @video
      render status: :not_found, json: { errors: { title: ["No video with title #{params["title"]}"] } }
    end
  end
end
