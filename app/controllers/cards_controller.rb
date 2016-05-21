class CardsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def home
    @card = if current_user.deck_id
      current_user.cards.where(deck_id: current_user.deck_id).random_card
    else
      current_user.cards.random_card
    end
  end

  def check
    @card = current_user.cards.find_by(id: params[:card_id])
    if @card.check_translation(params[:answer])
      redirect_to :back, notice: (t '.notice1')
    else
      if @card.check_levenshtein(params[:answer])
        redirect_to :back, notice: "#{params[:answer]} - #{t('.notice2')} [#{@card.original} - #{@card.translated}]"
      else
        redirect_to :back, alert: "#{params[:answer]} - #{t('.alert')} [#{@card.original} - #{@card.translated}]"
      end                            
    end
  end
  def index
    @cards = current_user.cards
  end

  def show
  end

  def new
    @card = current_user.cards.build
  end

  def edit
  end

  def create
    @card = current_user.cards.create(card_params)
    @card.save ? (redirect_to @card) : (render 'new')
  end

  def update
    @card.update(card_params) ? (redirect_to @card) : (render 'edit')
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private
    def set_user
      @card = current_user.cards.find_by(id: params[:id])
      redirect_to cards_path if @card.nil?
    end

    def card_params
      params.require(:card).permit(:original, :translated, :review, 
                     :avatar, :remove_avatar, :deck_id, :true_answers, :try)
    end
end
