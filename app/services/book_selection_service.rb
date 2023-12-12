# frozen_string_literal: true

class BookSelectionService
  include ActiveModel::Validations

  attr_accessor :student, :book

  validates :student, presence: true
  validates :book, presence: true

  def initialize(student_id, book_id)
    @student = Student.find(student_id)
    @book = Book.find(book_id)
  end


  def perform
    abooks = LearnableBook.where(student: @student).first&.books || []
    if @book.kind == 'FREE' || @student.vip_days > 0
      if abooks.size > 0 && @book.kind != 'FREE'
        a = abooks.detect {|b| b.id.to_s == @book.id.to_s}
        if a
          add_book
        else
          errors.add(:base, :invalid, message: "此课程尚未开通，请与负责老师联系！")
        end
      else
        add_book
      end
    else
      errors.add(:base, :invalid, message: "非VIP会员，不能加入课程。请充值后，再使用！")
    end

    return errors.size == 0

  end

  def add_book
    %w[read listen spell].each do |type|
      LearnedBook.find_or_create_by({
                                      student: @student,
                                      book: @book,
                                      learn_type: type,
                                    })
    end
  end
end
