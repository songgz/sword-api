require './lib/crawler/json_http'
require './lib/crawler/gls'
namespace :crawler do
  desc "TODO"
  task down: :environment do

    Gls.downBooks.each do |book|
      #p book['coverImgUrl']
      p b = Book.new({
                   no: book['bookNo'],
                   category: book['bookSort'],
                   kind: book['bookType'],
                   can_exam: book['canExam'],
                   unit_count: book['columns'],
                   cover: book['coverImgUrl'],
                   my_id: book['id'],
                   desc: book['info'],
                   name: book['name'],
                   seq: book['orders'],
                   status: book['status'],
                   word_count: book['words']
                 })
      b.save

      Gls.downUnit(book['bookNo']).each do |unit|
        u = Unit.new({
                         book: b,
                         book_no: unit['bookNo'],
                         no: unit['columnNo'],
                         name: unit['name'],
                         word_count: unit['words'],
                         status: unit['status'],
                         seq: unit['orders'],
                         my_id: unit['id']
                       })

        Gls.downWord(unit['columnNo']).each do |word|
          w = Dictionary.find_or_create_by({
                           book_category: word['bookSort'],
                           no: word['wordNo'],
                           word: word['content1'],
                           phonetic_ymbol: word['content2'],
                           acceptation: word['content3'],
                           example: word['content4'],
                           picture: word['content5'],
                           parse: word['content6'],
                           pronunciation: word['content7'],
                           usage: word['content8'],
                           status: word['status'],
                           seq: word['orders'],
                           my_id: word['id']
                         })
          u.words << w
          u.my_word_nos << word['wordNo']
        end
        u.save
        p u
      end
    end
  end

  desc "TODO"
  task my_task2: :environment do
  end

end
