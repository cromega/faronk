LOGS = [
  ["#channel", "cromega", "Look at this funny stuff", Time.current],
  ["#channel", "cromega", "https://www.youtube.com/watch?v=322nLkmwOws", Time.current + 3],
  ["#channel", "someone_else", "haha that is funny indeed", Time.current + 120],
]

LOGS.each do |log|
  Log.create!(
    channel: log[0],
    user: log[1],
    message: log[2],
    sent_at: log[3]
  )
end