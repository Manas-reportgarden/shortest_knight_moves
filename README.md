# Shortest Knight moves

Given a board setup up with initial knight position and destination, it finds the shortest path (minimum number of steps) for the knight to another position (destination) on the board.

# Setup
`$ bundle install` <br>
`$ rails s`

`* All responses from the app are JSON encoded`

# Run
<strong>url: `<app_url>/chess_boards` <br>
method: `POST` <br>
params: `{ knight_position: 'H1'}`
</strong>

You will get `board_id` as response. With that `board_id` call,

<strong>url: `<app_url>/knights/get_shortest_path` <br>
method: `GET` <br>
params: `{ board_id: '<board_id>', destination: 'G2' }`
</strong>
  
The response will contain the `shortest_path`.

# Test

`$ rpsec`
