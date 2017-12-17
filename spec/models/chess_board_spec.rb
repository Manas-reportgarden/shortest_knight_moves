describe ChessBoard do
  context 'returns chess board ID after initialization' do
    it 'return success response with board ID, if valid knight position is passed' do
      response = ChessBoard.new('H1').save

      expect(response[:board_id]).to eq(Digest::SHA256.hexdigest('H1'))
    end

    it 'returns failure response, if invalid knight position is passed' do
      response = ChessBoard.new('X1').save

      expect(response[:status]).to eq('FAIL')
    end
  end

  context 'instance methods' do
    before(:all) { @chess_board = ChessBoard.new('H1') }

    it 'returns char to index mapping for the chess board' do
      expect(@chess_board.char_index_mapping).to eq({"A"=>1, "B"=>2, "C"=>3, "D"=>4, "E"=>5, "F"=>6, "G"=>7, "H"=>8})
    end

    it 'splits the given characters to chess board position' do
      expect(@chess_board.split_char_to_position('H1')).to eq([8, 1])
    end

    it 'checks whether the move is within chess board' do
      expect(@chess_board.move_within_board(8, 1)).to eq(true)
    end

    it 'joins the chess board position to characters' do
      expect(@chess_board.join_position_to_char(8, 1)).to eq('H1')
    end
  end
end
