class ChessBoard
  attr_reader :knight_position

  BOARD_SIZE = (1..8)

  def initialize(knight_position)
    @knight_position = knight_position
  end

  def self.find(board_id)
    redis_conn.get(board_id)
  end

  def save
    if ChessBoard.is_valid_position(knight_position)
      ChessBoard.redis_conn.set(board_id, knight_position)

      { status: 'OK', board_id: board_id }
    else
      { status: 'FAIL', message: 'Invalid Knight Position' }
    end
  end

  def char_index_mapping
    @char_index_mapping ||= BOARD_SIZE.each_with_object({}) do |index, hash|
      hash[(64+index).chr] = index
    end
  end

  def split_char_to_position(char)
    x, y = char.split('')
    [char_index_mapping[x], y.to_i]
  end

  def move_within_board(x, y)
    BOARD_SIZE.include?(x) && BOARD_SIZE.include?(y)
  end

  def join_position_to_char(x, y)
    "#{char_index_mapping.key(x)}#{y}"
  end

  def self.is_valid_position(char)
    chess_board = ChessBoard.new(char)
    position = chess_board.split_char_to_position(char)

    chess_board.move_within_board(*position)
  end

  private
  # Establish Redis connection
  def self.redis_conn
    @redis_conn ||= Redis.new
  end

  def board_id
    Digest::SHA256.hexdigest(knight_position)
  end
end
