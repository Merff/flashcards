class DecksController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
    def set_user
      @deck = current_user.decks.find_by(id: params[:id])
      redirect_to decks_path if @deck.nil?
    end

    def deck_params
      params.require(:deck).permit(:name)
    end
end
