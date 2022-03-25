1.upto(10).each do |n|
	Note.create(content: Faker::Lorem.paragraph(sentence_count: rand(1..5)))
end