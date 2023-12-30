class V1::StatisticsController < ApplicationController


  def week
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week
    student_id = params[:student_id]

    result = LearnedWord.collection.aggregate([
                                 { "$match" => {
                                   "student_id" => BSON::ObjectId(student_id),
                                   "day" => {"$gte" => start_date, "$lte" => end_date }}
                                 },
                                 { "$group" => {
                                   "_id" => {"$dayOfWeek" => "$day"},
                                   "day" => { "$first" => "$day" },
                                   "total_duration" => { "$sum" => "$duration" },
                                   "total_words" => {"$sum" => 1}
                                 }
                                 },
                                 { "$sort" => { "_id" => 1 } },
                                 {
                                   "$project" => {
                                     "_id" => 0,
                                     "week" => "$_id",
                                     "day" => 1,
                                     "total_duration" => 1,
                                     "total_words" => 1
                                   }
                                 }
                               ]).to_a

    data = {weeks: [],days: [], durations: [], words: []}
    (0..6).each do |i|
      data[:weeks] << i
      data[:days] << start_date + i
      p start_date + i
      p result
      d = result.detect {|r| r["week"] == i+1}
      if d
        data[:durations] << d["total_duration"]
        data[:words] << d["total_words"]
      else
        data[:durations] << 0
        data[:words] << 0
      end

    end

    render json: {data: data}, status: :ok

  end



end
