require "faker"

module Comment
    SENTENCE = 0
    SENTENCES = 1
    PARAGRAPH = 2
    PARAGRAPHS = 3
end

limits = [ 10, 100, 200 ]

Product.all.each do |product|
    limit = limits.sample
    review_count = rand(limit)

    User.order('RANDOM()').limit(limit).each do |user|
        comment_size = [
            Comment::SENTENCE,
            Comment::SENTENCES,
            Comment::PARAGRAPH,
            Comment::PARAGRAPHS
        ].sample

        comment = case comment_size
                  in Comment::SENTENCE
                      Faker::Lorem.sentence
                  in Comment::SENTENCES
                      Faker::Lorem.sentences(number: rand(5)).join("\n\n")
                  in Comment::PARAGRAPH
                      Faker::Lorem.paragraph
                  in Comment::PARAGRAPHS
                      Faker::Lorem.paragraphs(number: rand(3)).join("\n\n")
                  else
                      Faker::Lorem.sentence
                  end

        product.reviews.create(
            score: rand(1..5),
            comment: comment,
            user_id: user.id
        )
    end
end


