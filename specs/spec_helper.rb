require 'yamazaki'
require 'date'
require 'base64'
#require 'random'

def make_torrent(episode, options={})
  description = options[:description] || "No description"
  pub_date    = options[:pub_date]    || DateTime.now.to_s
  link        = options[:link]        || "http:/u.rl/this.torrent"
  index       = options[:index]       || 0
  filename    = options[:filename]    || "/no/filename"
  Yamazaki::Torrent.new(episode, description, pub_date, link, index, filename)
end

def prepare_db(torrents)
  db_file_path = "/tmp/" + Base64.strict_encode64((Random.rand*255).to_s) + ".db"
  File.rm db_file_path if File.exists? db_file_path
  if torrents.size > 0
    db = Yamazaki::Database.new(db_file_path, save_on_push=true)
    torrents.each { |torrent| db << torrent.filename }
  end
  db_file_path
end
