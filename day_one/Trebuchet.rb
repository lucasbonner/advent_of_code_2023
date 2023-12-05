all_digits = []

File.open('input.txt').each do |line|
  digits = line.chars.select{ |char| char.to_i.to_s == char }.map{ |char| char.to_i }
  all_digits << digits
end

all_digits.select! { |sub| !sub.empty? }
all_digits.map! do |sub|
  if sub.length == 1
    sub << sub[0]
  elsif sub.length > 2
    sub = sub.values_at(0, -1)
  else
    sub
  end
end

print all_digits.map! {|sub| sub.join.to_i }.inject(0, :+)
