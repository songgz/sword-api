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
                                   "total_duration" => { "$sum" => "$duration" },
                                   "total_word" => {"$sum" => 1}}
                                 },
                                 { "$sort" => { "_id" => 1 } },
                                 {
                                   "$project" => {
                                     "_id" => 0,
                                     "week" => "$_id",
                                     "day" => 1,
                                     "total_duration" => 1,
                                     "total_word" => 1
                                   }
                                 }
                               ]).to_a if student_id.present?

    data = {weeks: [],days: [], durations: [], words: []}
    (0..6).each do |i|
      data[:weeks] << i
      data[:days] << start_date + i
      d = result.detect {|r| r["week"] == i+1}
      if d
        data[:durations] << d["total_duration"]
        data[:words] << d["total_word"]
      else
        data[:durations] << 0
        data[:words] << 0
      end
    end

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
                                                  "total_duration" => { "$sum" => "$duration" },
                                                  "total_word" => {"$sum" => 1}}
                                                },
                                                { "$sort" => { "_id" => 1 } },
                                                {
                                                  "$project" => {
                                                    "_id" => 0,
                                                    "seq" => "$_id",
                                                    "day" => 1,
                                                    "total_duration" => 1,
                                                    "total_word" => 1
                                                  }
                                                }
                                              ]).to_a if student_id.present?

    data = {seq: [],days: [], durations: [], words: []}
    (0..(end_date.day-1)).each do |i|
      data[:seq] << i
      data[:days] << start_date + i
      d = result.detect {|r| r["seq"] == i+1}
      if d
        data[:durations] << d["total_duration"]
        data[:words] << d["total_word"]
      else
        data[:durations] << 0
        data[:words] << 0
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
                                                  "first_day" => { "$first" => "$day" },
                                                  "total_duration" => { "$sum" => "$duration" },
                                                  "total_word" => {"$sum" => 1}}
                                                },
                                                { "$sort" => { "_id" => 1 } },
                                                {
                                                  "$project" => {
                                                    "_id" => 0,
                                                    "seq" => "$_id",
                                                    "day" => { "$dateToString" => { "format" => "%Y-%m", "date" => "$first_day" } },
                                                    "total_duration" => 1,
                                                    "total_word" => 1
                                                  }
                                                }
                                              ]).to_a if student_id.present?


    data = {seq: [],days: [], durations: [], words: []}
    (0..11).each do |i|
      data[:seq] << i
      data[:days] << start_date + i
      d = result.detect {|r| r["seq"] == i+1}
      if d
        data[:durations] << d["total_duration"]
        data[:words] << d["total_word"]
      else
        data[:durations] << 0
        data[:words] << 0
      end
    end

    render json: {data: data}, status: :ok
  end




end
