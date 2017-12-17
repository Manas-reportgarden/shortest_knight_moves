class ChessBoardsController < ApplicationController
  def create
    response = ChessBoard.new(params[:knight_position]).save

    render json: response
  rescue StandardError => ex
    render json: { status: 'FAIL', message: ex.message }
  end
end
