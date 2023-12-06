sum = 0

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
  game_scores.slice!("Game #{game_id}:")
  p game_scores.delete(' ').split(',')
  #   p color_score
  #   color = get_color(color_score.chars.select! {|char| char.to_i.to_s != char}[0])
  #   number = color_score.chars.select! {|char| char.to_i.to_s == char}
  #   if number.length != 1
  #     number = number.join('').to_i
  #   else
  #     number = number[0].to_i
  #   end

  # end
end

def count_hand(hand, values)
  hand.split(',').each do |pull|
    color = get_color(pull.chars.select { |char| char.to_i.to_s != char }[0])
    number = pull.chars.select { |char| char.to_i.to_s == char}
    if number.length != 1
      number = number.join('').to_i
    else
      number = number[0].to_i
    end

    if values["#{color.upcase}"] < number
      values["#{color.upcase}"] = number
    end
  end
  return values
end

def get_max(game, game_id)
  game.slice!("Game #{game_id}:")
  values = {
    "RED" => 0,
    "GREEN" => 0,
    "BLUE" => 0,
  }

  game.delete(' ').split(';').each do |hand|
    values = count_hand(hand, values)
  end
  return values
end

File.open('input.txt').each do |line|
  game_id = line.split(' ').select { |word| word == line.split(' ')[1] }.map { |id| id.split(':') }[0][0]
  line.split('\n').each do |game|
    cubed = 1
    max_values = get_max(game, game_id)
    max_values.each do |_, value|
      cubed *= value
    end
    sum += cubed
  end
end

p sum
