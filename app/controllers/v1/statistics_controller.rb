class V1::StatisticsController < ApplicationController


  def week
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week
    student_id = params[:student_id]

    result = []
    result = LearnedWord.collection.aggregate([
                                 { "$match" => {
                                   "student_id" => BSON::ObjectId(student_id),
                                   "day" => {"$gte" => start_date, "$lte" => end_date }}
                                 },
                                 { "$group" => {
                                   "_id" => {"$dayOfWeek" => "$day"},
                                   "day" => { "$first" => "$day" },
                                   "durations" => { "$sum" => "$durations" },
                                   "completions" => {"$sum" => "$completions"},
                                   "reviews" => {"$sum" => "$reviews"}}
                                 },
                                 { "$sort" => { "_id" => 1 } },
                                 {
                                   "$project" => {
                                     "_id" => 0,
                                     "week" => "$_id",
                                     "day" => 1,
                                     "durations" => 1,
                                     "completions" => 1,
                                     "reviews" => 1
                                   }
                                 }
                               ]).to_a if student_id.present?
    p result
    Rails.logger.info result
    data = {weeks: [],days: [], durations: [], completions: [], reviews: []}
    (0..6).each do |i|
      data[:weeks] << i
      data[:days] << start_date + i
      d = result.detect {|r| r["week"] == (i+1)%7 + 1}
      if d
        data[:durations] << (d["durations"]/60).round
        data[:completions] << d["completions"]
        data[:reviews] << d["reviews"]
      else
        data[:durations] << 0
        data[:completions] << 0
        data[:reviews] << 0
      end
    end
    p data
    render json: {data: data}, status: :ok
  end

  def month
    student_id = params[:student_id]
    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month
    result = []
    result = LearnedWord.collection.aggregate([
                                                { "$match" => {
                                                  "student_id" => BSON::ObjectId(student_id),
                                                  "day" => {"$gte" => start_date, "$lte" => end_date }}
                                                },
                                                { "$group" => {
                                                  "_id" => {"$dayOfMonth" => "$day"},
                                                  "day" => { "$first" => "$day" },
                                                  "durations" => { "$sum" => "$durations" },
                                                  "completions" => {"$sum" => "$completions"},
                                                  "reviews" => {"$sum" => "$reviews"}}
                                                },
                                                {
                                                  "$project" => {
                                                    "_id" => 0,
                                                    "seq" => "$_id",
                                                    "day" => 1,
                                                    "durations" => 1,
                                                    "completions" => 1,
                                                    "reviews" => 1
                                                  }
                                                }
                                              ]).to_a if student_id.present?
    p result

    data = {seq: [],days: [], durations: [], completions: [], reviews: []}
    (0..(end_date.day-1)).each do |i|
      data[:seq] << i
      data[:days] << start_date + i
      d = result.detect {|r| r["seq"] == i+1}
      if d
        data[:durations] << (d["durations"]/60).round
        data[:completions] << d["completions"]
        data[:reviews] << d["reviews"]
      else
        data[:durations] << 0
        data[:completions] << 0
        data[:reviews] << 0
      end
    end

    render json: {data: data}, status: :ok
  end

  def year
    student_id = params[:student_id]
    start_date = Date.today.beginning_of_year
    end_date = Date.today.end_of_year
    result = []
    result = LearnedWord.collection.aggregate([
                                                { "$match" => {
                                                  "student_id" => BSON::ObjectId(student_id),
                                                  "day" => {"$gte" => start_date, "$lte" => end_date }}
                                                },
                                                { "$group" => {
                                                  "_id" => {"$month" => "$day"},
                                                  "day" => { "$first" => "$day" },
                                                  "durations" => { "$sum" => "$durations" },
                                                  "completions" => {"$sum" => "$completions"},
                                                  "reviews" => {"$sum" => "$reviews"}}
                                                },
                                                { "$sort" => { "_id" => 1 } },
                                                {
                                                  "$project" => {
                                                    "_id" => 0,
                                                    "seq" => "$_id",
                                                    "day" => { "$dateToString" => { "format" => "%Y-%m", "date" => "$first_day" } },
                                                    "durations" => 1,
                                                    "completions" => 1,
                                                    "reviews" => 1
                                                  }
                                                }
                                              ]).to_a if student_id.present?


    data = {seq: [],days: [], durations: [], completions: [], reviews: []}
    (0..11).each do |i|
      data[:seq] << i
      data[:days] << "#{start_date.year}-#{i+1}"
      d = result.detect {|r| r["seq"] == i+1}
      if d
        data[:durations] << (d["durations"]/60).round
        data[:completions] << d["completions"]
        data[:reviews] << d["reviews"]
      else
        data[:durations] << 0
        data[:completions] << 0
        data[:reviews] << 0
      end
    end

    render json: {data: data}, status: :ok
  end

  def notebook
    student_id = params[:student_id]
    result = []
    result = LearnedBook.collection.aggregate([
                                                { "$match" => {
                                                  "student_id" => BSON::ObjectId(student_id) }
                                                },
                                                { "$group" => {
                                                  "_id" => "$book_id",
                                                  "book_name" => { "$first" => "$book_name" },
                                                  "book_cover" => { "$first" => "$book_cover" },
                                                  "words" => { "$addToSet" => {"learned_book_id" => "$_id" ,"learn_type"=> "$learn_type", "wrongs"=> "$wrongs"}}}
                                                },
                                                { "$project" => {
                                                    "_id" => 0,
                                                    "book_id" => "$_id",
                                                    "book_name" => 1,
                                                    "book_cover" => 1,
                                                    "words" => 1 }
                                                }
                                              ]).to_a if student_id.present?
    render json: {data: result}, status: :ok
  end




end
