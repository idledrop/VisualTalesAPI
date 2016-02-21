class Api::EventsController < ApiController

  before_action :fetch_scene, only: [:index, :create]

  def index
    events = @scene.events

    unless events.empty?
      render json: expanded_json(events)

    else
      render nothing: true, status: :no_content
    end
  end

  def create

    event = @scene.events.new(params.permit(:position_x,:position_y,:script,:order, :pose_id))

    if event.save
      render json: expanded_json(event), status: :created
    else
      render json: event.errors, status: :unprocessable_entity
    end

  end

  def update
    event = Event.find(params[:id])
    if event.update_attributes(params.permit(:position_x,:position_y,:order,:script,:pose_id))
      render json: expanded_json(event)
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    render nothing: true, status: :no_content
  end

  private
  def fetch_scene
    @scene = Scene.eager_load([:events, :poses]).find(params[:scene_id])
  end

  def expanded_json(events)
    events.as_json(
        only: [:id, :position_x, :position_y, :order, :script],
        include: { pose: { only: [:id, :name, :image],
                           include: {character: { only: [:id, :name, :description, :portrait]
                           }
                           }
        }
        }
    )
  end

end