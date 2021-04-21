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
	module Core
		LIST   = 'http://www.nyaa.si/?page=rss&cats=1_0'.freeze
		SEARCH = 'http://www.nyaa.si/?page=rss&term='.freeze

		def list(n = nil)
			[].tap do |items|
				lrss = RSS::Parser.parse(open(LIST))

				n ||= items.size
				0.upto(n-1) { |no| items << Torrent.from_rss(lrss.items[no], no) }
			end
		end

		def search(key)
			raise ArgumentError, 'Valid keywords were expected.'.freeze if key.to_s.strip.empty?

			[].tap do |items|
				url = "#{SEARCH}#{key.gsub(' '.freeze, ?+)}"
				rss = RSS::Parser.parse(open(url))

				0.upto(rss.items.size-1) { |n| items << Torrent.from_rss(rss.items[n], n) }
			end
		end
	end
end
