require 'open-uri'
page = Nokogiri::HTML(open("http://wordsteps.com/vocabulary/words/121275/%D0%A4%D1%80%D1%83%D0%BA%D1%82%D1%8B"))

page.css("tr.wrow").each do |tr|
  Card.create(
    original:   tr.css("div.word").text,
    translated: tr.css("div.trans").text,
    review:     (DateTime.now.to_date + 3),
    user_id:    User.take(1),
    deck_id:
    )
end