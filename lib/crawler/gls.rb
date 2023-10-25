#require './json_http'
require 'digest'

class Gls

  def self.sign_value(params = {})
    default = {
      "columnNo": "1383252095992279041",
      "token": "55D050692DBD311ED28F2060752C14D939244D043C8EE1F12172EA37886811465642F42E393604AD",
      "ts": (Time.now).strftime("%Y%m%d%H%M%S"),
      "version": "1.0.0"
    }
    str = default.merge(params).map { |k, v| "#{k}=#{v}" }.sort.join('&')
    return str
  end

  def self.sign(sign_value)
    str = "#{sign_value}&key=4be01a615e5deb0b37d30864e8eb0373"
    return Digest::MD5.hexdigest(str)
  end

  def self.downWord(unit_no)
    v = sign_value({ "columnNo": unit_no })
    url = "http://app.gaolesheng.cn/api/bookColumn/allWords?#{v}&sign=#{sign(v)}"
    data = JsonHttp.get(url)
    #    JsonHttp.save("json/word_#{unit_no}.json", data.to_json.to_s)
    return  data['data']
  end

  def self.downUnit(book_no)
    v = sign_value({ "bookNo": book_no, "learnType": "DEFAULT" })
    url = "http://app.gaolesheng.cn/api/bookColumn/list?#{v}&sign=#{sign(v)}"
    #url = "http://app.gaolesheng.cn/api/bookColumn/list?learnType=DEFAULT&bookNo=#{book_no}&token=55D050692DBD311E11FAA3A312BD3CBF74EA11AFC4BFF634E37648F121393DC0709D9178CC3E82F0&version=1.0.0&ts=20230919085835&sign=5ae7b46b04bdb01532f4dd3727ce7dbe"
    data = JsonHttp.get(url)
    #JsonHttp.save("json/unit_#{book_no}.json", data.to_json.to_s)
    return data['data']['columns']
  end

  def self.downBooks
    v = sign_value({ "page": 0, "size": 1000 })
    url = "http://app.gaolesheng.cn/api/book/list?#{v}&sign=#{sign(v)}"
    #url = 'http://app.gaolesheng.cn/api/book/list?page=0&size=1000&token=55D050692DBD311E11FAA3A312BD3CBF74EA11AFC4BFF634E37648F121393DC0709D9178CC3E82F0&version=1.0.0&ts=20230919085821&sign=cc3b258f132a47e5915833d029379739'
    data = JsonHttp.get(url)

    #JsonHttp.save("json/books.json", data.to_json.to_s)
    return data['data']['content']
  end
end

if __FILE__ == $0

   Gls.downBooks.each do |book|
     p book['coverImgUrl']
     a << book['bookNo']
     p Book.new

  #   $stderr.puts "book#{book['id']}=#{book['bookNo']}"
  #   JsonHttp.down(book['coverImgUrl']) if book['coverImgUrl']
  #
  #   Gls.downUnit(book['bookNo']).each do |unit|
  #     p "unit#{unit['orders']}=#{unit['columnNo']}"
  #     Gls.downWord(unit['columnNo']).each do |word|
  #       JsonHttp.down(word['content5']) if word['content5']
  #       JsonHttp.down(word['content7']) if word['content7']
  #     end
  #   end
   end
  p a.sort
  p a.size

end
