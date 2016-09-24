json.array!(@dash_boards) do |dash_board|
  json.extract! dash_board, :id
  json.url dash_board_url(dash_board, format: :json)
end
