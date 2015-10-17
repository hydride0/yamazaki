require_relative 'spec_helper'

describe Yamazaki::Database do

  describe '#new' do
    context 'when track file does not exist' do
      it 'is created correctly' do
        File.rm "./yam.db" if File.exists? "./yam.db"
        db = Yamazaki::Database.new("/tmp/yam.db", false)
        expect(db).to be_empty
      end
    end

    context 'when track file already exists' do
      it 'is loaded correctly if the given `track_file` contains something' do
        track_file = prepare_db([make_torrent("Nisekoi 01x11", {filename:"/home/roxas/nisenever_s1ep11.torrent"})])
        db = Yamazaki::Database.new(track_file)
        expect(db).not_to be_empty
        expect(db.include? "/home/roxas/nisenever_s1ep11.torrent").to be_truthy()
      end

      it 'is loaded correctly if `track_file` is empty' do
        track_file = prepare_db([])
        db = Yamazaki::Database.new(track_file)
        expect(db.size).to eq(0) 
      end
    end
  end
  
  describe '#<<' do
    context 'insertion behaviour' do
      it 'inserts a new filename into an empty database' do
        track_file = prepare_db([])
        db = Yamazaki::Database.new(track_file)
        db << "/home/pls/sword_art_online.torrent"
        expect(db).not_to be_empty
        expect(db.include? "/home/pls/sword_art_online.torrent").to be_truthy()
      end


      it 'does not insert the same filename if already present' do
        skip 'skip: if needed, a file can be re-downloaded, and we want it to be possible'
        track_file = prepare_db([])
        db = Yamazaki::Database.new(track_file)
        db << "/home/pls/sword_art_online.torrent"
        db << "/home/pls/sword_art_online.torrent"
        #if we cannot have several duplicates, the size
        #should always be 1
        expect(db.size).to be(1)
      end
    end

    context 'when `save_on_push` is enabled (default)' do
      it 'database saves filenames on disk' do
        #if `save_on_push` is disabled, we should not find
        #any of the previously inserted filenames
        #if we re-open the track file.
        track_file = prepare_db([])
        db = Yamazaki::Database.new(track_file)
        db << "/sora/no/woto.torrent"
        other_db = Yamazaki::Database.new(track_file, true)
        #we want to explicitely check the size here
        expect(db.size).to       eq(1)
        expect(other_db.size).to eq(1)
      end
    end


    context 'when `save_on_push` is disabled' do
      it 'database does not save filenames on disk' do
        #if `save_on_push` is disabled, we should not find
        #any of the previously inserted filenames
        #if we re-open the track file.
        track_file = prepare_db([])
        db = Yamazaki::Database.new(track_file, false)
        db << "/sora/no/woto.torrent"
        other_db = Yamazaki::Database.new(track_file, false)
	#check the size, not its emptiness
        expect(db.size).to       eq(1)
        expect(other_db.size).to eq(0)
      end
    end
  end

  describe '#include?' do
    context 'when looking into an empty database' do
      it 'is not found inside the database' do
        track_file = prepare_db([])
        db = Yamazaki::Database.new(track_file)
        expect(db.include? "/home/winter/human_reignition_project_PV.torrent").to be_falsey()
      end
    end
  end

end
