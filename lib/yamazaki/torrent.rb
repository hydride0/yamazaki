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
    class Torrent
        attr_reader :title, :description, :pub_date, :link, :index

        def initialize(title, description, pub_date, link, index = 0)
            @title = title
            @description = description
            @pub_date = pub_date
            @link = link
            @index = index
        end

        def to_s
            "#{(@index + 1).to_s.black.cyan} #{@title.bold} #{@pub_date.strftime('%m/%d/%Y %H:%M').color(50)}\n"
        end

        class << self
            def from_rss(hash, index)
                Torrent.new(hash.title, hash.description, hash.pubDate, hash.link, index)
            end
        end
    end
end
