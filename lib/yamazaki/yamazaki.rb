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
		LIST = 'http://www.nyaa.se/?page=rss&cats=1_0'
		SEARCH = 'http://www.nyaa.se/?page=rss&term='
		DEFAULT_WATCH_DIR = File.join ENV['HOME'], '.watch'

		def list
			lrss = RSS::Parser.parse(open(LIST))
			puts "Last 5 torrents on Nyaa (#{Time.now.hour}:#{Time.now.min})\n\n".cyan.bold
			return if lrss.items.empty?

			0.upto(4) { |no| puts print_item(lrss.items[no], no) }
			Yamazaki.download lrss.items
		end
		
		def search(key)
			raise ArgumentError, 'Valid keywords were expected.' if key.to_s.strip.empty?

			url = "#{SEARCH}#{key.gsub(' ', ?+)}"
			rss = RSS::Parser.parse(open(url))
			return if rss.items.empty?

			0.upto(rss.items.size-1) { |n| puts "#{print_item(rss.items[n], n)}\t#{rss.items[n].description}" }
			Yamazaki.download rss.items
		end

		def download(ary)
			num = Yamazaki.prompt
			Yamazaki.download_torrent(ary[num].title, ary[num].link) if num >= 0 || num <= 5
		end

		def download_torrent(name, link)
			watch_dir = defined?(WATCH_DIR) == 'constant' ? WATCH_DIR : DEFAULT_WATCH_DIR
			open("#{watch_dir}/#{name}.torrent", ?w) { |out| out.write(open(link).read) }
		end

		def print_item(item, n)
			"#{(n+1).to_s.black.cyan} #{item.title.bold} #{item.pubDate.strftime('%m/%d/%Y %H:%M').color(50)}\n"
		end

		def prompt
			print '>> '
			STDIN.gets.to_i - 1
		end
	end
end
