sum = 0
VALID_COUNTS = {
  "RED": 12,
  "GREEN": 13,
  "BLUE": 14
}

def valid(color, number)
  number <= VALID_COUNTS[:"#{color.upcase}"]
end

def get_color(string)
  case string
  when "b"
    "Blue"
  when "g"
    "Green"
  when "r"
    "Red"
  end
end

def tally(game_scores, game_id)
  result = true
  game_scores.slice!("Game #{game_id}:")
  game_scores.delete(' ').split(',').select! do |color_score|
    color = get_color(color_score.chars.select! {|char| char.to_i.to_s != char}[0])
    number = color_score.chars.select! {|char| char.to_i.to_s == char}
    if number.length != 1
      number = number.join('').to_i
    else
      number = number[0].to_i
    end
    if !valid(color, number)
      result = false
    end
  end
  return result
end

File.open('input.txt').each do |line|
  add = true
  game_id = line.split(' ').select { |word| word == line.split(' ')[1] }.map { |id| id.split(':') }[0][0]
  line.split(';').each do |game|
    if !tally(game, game_id)
      add = false
    end
  end

  if add
    p game_id.to_i
    sum += game_id.to_i
  end
end

p sum
