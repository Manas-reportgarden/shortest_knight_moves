describe ChessBoardsController, type: :controller do
  context 'initializes the chess board and sends back the chess board ID' do
    it 'return success response with board ID, if valid knight position is passed' do
      response = post(:create, params: { knight_position: 'H1' })

      expect(JSON.parse(response.body)['board_id']).to eq(Digest::SHA256.hexdigest('H1'))
    end

    it 'returns failure response, if invalid knight position is passed' do
      response = post(:create, params: { knight_position: 'T1' })

      expect(JSON.parse(response.body)['status']).to eq('FAIL')
    end
  end
end
