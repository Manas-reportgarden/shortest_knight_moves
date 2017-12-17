class Knight < ChessBoard
  attr_reader :possible_moves, :start_position, :end_position
  attr_accessor :visited_destinations

  def initialize(start_position, end_position)
    @start_position = split_char_to_position(start_position)
    @end_position = split_char_to_position(end_position)

    @visited_destinations = []
    @possible_moves = [[-2,  1], [-1,  2], [1,  2], [2,  1], [-2, -1], [-1, -2], [1, -2], [2, -1]].freeze
  end

  # Process:
  # With the initial start position add all possible next destinations
  # Check if those destinations have the end position. If not, continue
  # the whole process until you reach the end position.
  def get_shortest_path
    start_knight_movement = { position: start_position, source: {} }

    knight_movements = [start_knight_movement]

    while knight_movements.present?
      knight_movement = knight_movements.shift

      position = knight_movement[:position]

      if position == end_position
        return movements_from_source(knight_movement, start_knight_movement)
      end

      add_possible_destination_movements(position, knight_movement, knight_movements)
    end
  end

  # Returns all the next possible unvisited destinations by the knight
  # with regards to the position sent as the parameter.
  def possible_destinations(position)
    possible_moves = possible_moves_in_board(position)

    possible_destinations = possible_moves.map do |move|
      [move[0] + position[0], move[1] + position[1]]
    end.uniq

    possible_destinations - visited_destinations
  end

  # Returns all the next possible moves within the board.
  def possible_moves_in_board(position)
    possible_moves.select do |move|
      x = position[0] + move[0]
      y = position[1] + move[1]

      move_within_board(x, y)
    end
  end

  # Returns all the position of movements tracking from the destination
  # to the source.
  def movements_from_source(knight_movement, start_knight_movement)
    movement_position = []

    loop do
      movement_position << join_position_to_char(*knight_movement[:position])

      if knight_movement == start_knight_movement
        return movement_position.reverse.to_sentence
      end

      knight_movement = knight_movement[:source]
    end
  end

  private
  # Adds all the next possible destinations to knights movements.
  def add_possible_destination_movements(position, knight_movement, knight_movements)
    possible_destinations = possible_destinations(position)

    possible_destinations.each do |possible_destination|
      add_movement(possible_destination, knight_movement, knight_movements)
    end
  end

  # Add movement to next destination with position as the destination
  # and knight_movement at the source. The source will be used to track the movements
  # position from destination to source. Add the destination to knight's visited destination.
  def add_movement(destination, knight_movement, knight_movements)
    self.visited_destinations << destination
    knight_movements << { position: destination, source: knight_movement }
  end
end
