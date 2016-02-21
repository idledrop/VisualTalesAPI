class Api::EventsController < ApiController

  before_action :fetch_scene, only: [:index]

  def index
    events = @scene.events

    unless events.empty?
      # render json: events

      render events
    else
      render nothing: true, status: :no_content
    end
  end

  private
  def fetch_scene
    @scene = Scene.eager_load([:events, :poses]).find(params[:scene_id])
  end

end