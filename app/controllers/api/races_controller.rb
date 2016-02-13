module Api
  class RacesController < ApplicationController
    before_action :set_race, only: [:show, :edit, :update, :destroy]

    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
    end

    def index
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      else
      end
    end

    def show
      if request.accept && request.accept != '*/*'
        render json: @race, status: :ok
      else
      end
    end

    def results
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:id]}/results"
      else
      end
    end

    def result
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
      end
    end

    def create
      if request.accept && request.accept != '*/*'
        @race = Race.new(race_params)
        if @race.save
          render plain: @race.name, status: :created
        else
          render json: @race.errors, status: :unprocessable_entity
        end
      else
      end
    end

    def update
      Rails.logger.debug("method=#{request.method}")
      if @race.update(race_params)
        render json: @race, status: :ok
      else
      end
    end

    def destroy
      @race.destroy
      render nothing: true, status: :no_content
    end

    private

    def race_params
      params.require(:race).permit(:name, :date)
    end

    def set_race
      @race = Race.find(params[:id])
    end
  end
end
