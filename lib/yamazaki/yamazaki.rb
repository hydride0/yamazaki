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
		include Core

		DEFAULT_WATCH_DIR = File.join ENV['HOME'], '.watch'
		DEFAULT_TRACK_FILE = File.join ENV['HOME'], '.yam.db'

		def list(n)
			n = 5 if n.to_i == 0

			items = super(n)

			puts "Last #{n} torrents on Nyaa (#{Time.now.hour}:#{Time.now.min})\n\n".cyan.bold
			return if items.empty?

			items.each { |item| puts item.to_s }
			prompt_download items
		end

		def search(key)
			items = super(key)
			return if items.empty?

			items.each { |item| puts "#{item.to_s}\t#{item.description}" }
			prompt_download items
		end

		def download_torrent(name, link, force = false)
			name.gsub! '/', '-'

			watch_dir = defined?(WATCH_DIR) == 'constant' ? WATCH_DIR : DEFAULT_WATCH_DIR
			filename  = "#{watch_dir}/#{name}.torrent"

			if force != true && torrent_downloaded?(filename)
				false
			else
				download(filename)
			end
		end

	protected

		def torrent_downloaded?(filename)
			(@db ||= load_database).include?(filename)
		end

		def download(filename)
			File.open(filename, 'wb') do |torrent_file|
				torrent_file.write(open(link).read)
			end

			(@db ||= load_database) << filename
		end

	private

		def load_database
			track_file = defined?(TRACK_FILE) == 'constant' ? TRACK_FILE : DEFAULT_TRACK_FILE
			@db = Database.new(track_file)
		end

		def prompt_download(ary)
			num = prompt
			download_torrent(ary[num].title, ary[num].link) if num >= 0 && num <= ary.length
		end

		def prompt
			print '>> '
			STDIN.gets.to_i - 1
		end
	end
end
