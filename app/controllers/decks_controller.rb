class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  def current_deck
    current_user.update_attributes(deck_id: params[:id])
    redirect_to root_path
  end

  def index
    @decks = current_user.decks
  end

  def show
  end

  def new
    @deck = current_user.decks.build
  end

  def edit
  end

  def create
    @deck = current_user.decks.create(deck_params)
    @deck.save ? (redirect_to @deck) : (render 'new')
  end

  def update
    @deck.update(deck_params) ? (redirect_to @deck) : (render 'edit')
  end

  def destroy
    @deck.destroy
    redirect_to decks_path
  end

  private
    def set_deck
      @deck = current_user.decks.find_by(id: params[:id])
      redirect_to decks_path unless @deck
    end

    def deck_params
      params.require(:deck).permit(:name)
    end
end
