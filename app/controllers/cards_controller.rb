class CardsController < ApplicationController
	def index
		@cards = Card.all
	end

	def show
		@card = Card.find(params[:id])
	end

	def new
	end

	def create
		@card = Card.new(card_params)

		@card.save
		redirect_to @card
	end
end

private
	def card_params
		params.require(:card).permit(:original, :translated, :review)
	end