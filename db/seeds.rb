require 'open-uri'
page = Nokogiri::HTML(open("http://wordsteps.com/vocabulary/words/121275/%D0%A4%D1%80%D1%83%D0%BA%D1%82%D1%8B"))
	en  = Array.new 
	rus = Array.new
page.xpath('//div[@class = "static word"]').each do |en_word|
	en << en_word.text
end
page.xpath('//div[@class = "static trans"]').each do |rus_word|
	rus << rus_word.text
end
en.size.times do |i|
	Card.create(original: en[i], translated: rus[i])
end