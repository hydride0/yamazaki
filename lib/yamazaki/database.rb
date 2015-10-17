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
	class Database
		def initialize(track_file, save_on_push = true)
			@track_file   = track_file
			@save_on_push = save_on_push

			@db   = Oj.load(File.read(track_file)) if File.exists?(track_file)
			@db ||= []
			@db.sort_by! { |t| t[:filename] }
		end

		def <<(filename)
			@db << { filename: filename, added_at: Time.now }
			@db.sort_by! { |t| t[:filename] }
			save if @save_on_push
		end

		def include?(filename)
			begin
				@db.bsearch { |t| t[:filename] >= filename }[:filename] == filename
			rescue
				false 
			end 
		end

		def size
			@db.size
		end

		private

		def save
			File.open(@track_file, ?w) do |f|
				f.write(Oj.dump(@db))
			end
		end
	end
end
