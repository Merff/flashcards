class CardsController < ApplicationController
	def home
		@card = Card.random_card
	end

	def inspection
		@card = Card.find(params[:card_id])
		if @card.update_card(params.permit(:answer))
			redirect_to :back, notice: "Верный ответ!"
		else
			redirect_to :back, notice: "Неверный ответ("
		end
	end
	def index
		@cards = Card.all
	end

	def show
		@card = Card.find(params[:id])
	end

	def new
		@card = Card.new
	end

	def edit
		@card = Card.find(params[:id])
	end

	def create
		@card = Card.new(card_params)
		@card.save ? (redirect_to @card) : (render 'new')
	end

	def update
		@card = Card.find(params[:id])
		@card.update(card_params) ? (redirect_to @card) : (render 'edit')
	end

	def destroy
		@card = Card.find(params[:id])
		@card.destroy
		redirect_to cards_path
	end

	private
		def card_params
			params.require(:card).permit(:original, :translated, :review)
		end
end
