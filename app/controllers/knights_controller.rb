class KnightsController < ApplicationController
  def get_shortest_path
    knight_position = ChessBoard.find(params[:board_id])

    if knight_position.blank?
      render json: { status: 'FAIL', message: 'Invalid Board ID' } and return
    end

    end_position = params[:destination]
    unless ChessBoard.is_valid_position(end_position)
      render json: { status: 'FAIL', message: 'Invalid Destination sent' } and return
    end

    render json: { status: 'OK', shortest_path: Knight.new(knight_position, end_position).get_shortest_path }
  end
end
