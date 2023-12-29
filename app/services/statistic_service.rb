# frozen_string_literal: true

class StatisticService

  def initialize(student_id)
    @student = Student.find(student_id)
    @start_date = Date.today.beginning_of_week
    @end_date = Date.today.end_of_week
  end

  def perform
    Order.collection.aggregate([
                                 { "$match" => { "created_at" => { "$gte" => start_date, "$lte" => end_date } } },
                                 { "$group" => {
                                   "_id" => { "$dateToString" => { "format" => "%Y-%m-%d", "date" => "$created_at" } },
                                   "total_amount" => { "$sum" => "$amount" }
                                 }
                                 }
                               ])

  end
end
