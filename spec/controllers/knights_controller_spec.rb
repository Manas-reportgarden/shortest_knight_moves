describe KnightsController, type: :controller do
  context 'returns the shortest path' do
    before(:all) do
      @board_id = ChessBoard.new('H1').save[:board_id]
    end

    it 'return invalid board id message if invalid board ID is sent' do
      response = get(:get_shortest_path, params: { board_id: 'xyz' } )

      expect(JSON.parse(response.body)['message']).to eq('Invalid Board ID')
    end

    it 'return Destination message if invalid Destination is sent' do
      response = get(:get_shortest_path, params: { board_id: @board_id, destination: 'XX' } )

      expect(JSON.parse(response.body)['message']).to eq('Invalid Destination sent')
    end

    it 'returns the shortest path if all the valid params are sent' do
      response = get(:get_shortest_path, params: { board_id: @board_id, destination: 'G2' } )

      expect(JSON.parse(response.body)['shortest_path']).to eq('H1, F2, D3, F4, and G2')
    end
  end
end
