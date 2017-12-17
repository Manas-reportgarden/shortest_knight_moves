describe Knight do
  it 'returns the shortest path from the start_position to end_position' do
    expect(Knight.new('H1', 'G2').get_shortest_path).to eq('H1, F2, D3, F4, and G2')
  end

  context 'instance methods' do
    before(:all) { @knight_movement = Knight.new('H1', 'G2') }

    it 'returns all the next possible unvisited destinations' do
      possible_destinations = @knight_movement.possible_destinations([8, 1])

      expect(possible_destinations).to eq([[6, 2], [7, 3]])
    end

    it 'returns all the next possible moves within the board' do
      possible_moves_in_board = @knight_movement.possible_moves_in_board([8, 1])

      expect(possible_moves_in_board).to eq([[-2, 1], [-1, 2]])
    end

    it 'returns all the position of movements tracking from the destination to the source' do
      start_knight_movement = { position: [8, 1], source: {} }
      knight_movement = { position: [7, 2],
                          source: { position: [6, 4],
                                    source: { position: [4, 3],
                                              source: { position: [6, 2],
                                                        source: { position: [8, 1],
                                                                  source: {}}}}}}

      movements_from_source = @knight_movement.movements_from_source(knight_movement, start_knight_movement)

      expect(movements_from_source).to eq('H1, F2, D3, F4, and G2')
    end

    it 'adds movement to next destination with position as the destination and knight_movement at the source. Marks the desintations as visited' do
      knight_movements = []
      knight_movement = { position: [8, 1], source: {} }

      @knight_movement.send(:add_movement, [6, 2], knight_movement, knight_movements)

      expect(knight_movements).to eq([{:position=>[6, 2], :source=>{:position=>[8, 1], :source=>{}}}])
      expect(@knight_movement.visited_destinations).to eq([[6, 2]])
    end

    it 'adds all the next possible destinations to knights movements' do
      knight_movements = []
      knight_movement = { position: [8, 1], source: {} }

      @knight_movement.send(:add_possible_destination_movements, [8, 1], knight_movement, knight_movements)

      expect(knight_movements).to eq([{:position=>[7, 3], :source=>{:position=>[8, 1], :source=>{}}}])
    end
  end
end
