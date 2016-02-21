class Api::EventsController < ApiController

  def index
    events = Scene.find(params[:scene_id]).events

    render json: events
  end

end