require 'cgi'
require 'uri'
require 'net/http'
require 'json'
require"open-uri"
require"fileutils"

class JsonHttp
  def self.get(path, use_ssl: false)
    begin
      uri = URI(path)
    rescue
      uri = URI(CGI.escape(path))
    end
    req = Net::HTTP::Get.new(uri)
    #req['Content-Type'] = 'charset=gbk'
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: use_ssl) do |http|
      http.request(req)
    end
    if res.code == "301"
      res = Net::HTTP.get_response(URI.parse(res.header['location']))
    end
    JSON.parse(res.body)
  end

  def self.save(file, data)
    File.open(file, "w") do |f|
      f.write data
    end
  end

  def self.down(path)

    if path[0..6] == "/quick/"
      path = path[1..]
    end
    ext = File.extname(path)

    unless path.include?("quick/")
    case ext
    when '.jpg'
      path = "quick/img#{path}"
    when '.jpeg'
      path = "quick/img#{path}"
    when '.png'
      path = "quick/img#{path}"
    when '.mp3'
      path = "quick/v#{path}"
    else
      return
    end
    end


    return if File.exist?(path)
    host = "http://res.gaolesheng.cn"
    #curdir = Dir.pwd()
    url = host +"/"+ path
    root = File.dirname(path)

    begin
      Dir.mkdir(root) unless File.directory?(root)
      uri = URI(url)
      Net::HTTP.start(uri.host) { |http|
        resp = http.get(uri.path)
        File.open(path, "wb") { |file|
          file.write(resp.body)
        }
      }
      # data=open(url){|f|f.read}
      # open(path,"wb"){|f|f.write(data)}
    # case io = URI.open(url)
    #   when StringIO then File.open(path, 'wb') { |f| f.write(io.read) }
    #   when Tempfile then io.close; FileUtils.mv(io.path, path)
    # end
    rescue Exception => e
      $stderr.puts url
      #$stderr.puts e.full_message
      File.write('error.log', url + "\n", mode: 'a')
    end
  end
end




