##
## DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
## Version 2, December 2004
##
## Everyone is permitted to copy and distribute verbatim or modified
## copies of this license document, and changing it is allowed as long
## as the name is changed.
##
## DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
## TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
##
## 0. You just DO WHAT THE FUCK YOU WANT TO.
##

module Yamazaki
	class << self

		def list
			lurl = 'http://www.nyaa.se/?page=rss&cats=1_0'
			lrss = RSS::Parser.parse(open(lurl))
			puts "Last 5 torrents on Nyaa (#{Time.now.hour}:#{Time.now.min})\n\n".cyan.bold
			0.upto(4) { |no|
				puts "#{(no+1).to_s} #{lrss.items[no].title}\n"
			}	
			num = Yamazaki.prompt
			abort if num > 5 || num < 0
			Yamazaki.download lrss.items[num]
		end

		def prompt
			STDIN.gets.to_i - 1
		end

		def download(ary)
			open("#{WATCH_DIR}/#{ary.title}.torrent", 'w') { |out| out.write(open(ary.link).read) }
		end
		
		def search(key)
			url = "http://www.nyaa.se/?page=rss&term=#{key.gsub(' ', ?+)}"
			rss = RSS::Parser.parse(open(url))
			abort if key.empty? || rss.items.empty?
			0.upto(rss.items.size-1) { |n|
				puts "#{(n+1).to_s.black.yellow} #{'nyaa/'.magenta.bold}#{rss.items[n].title.bold} #{rss.items[n].pubDate.strftime('%m/%d/%Y %H:%M').green}\n\t#{rss.items[n].description}"
			}
			num = Yamazaki.prompt
			abort if num > rss.items.size || num < 0
			Yamazaki.download rss.items[num]
		end
	end
end
