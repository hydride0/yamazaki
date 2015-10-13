require_relative 'spec_helper'

describe Yamazaki::Torrent do
  #include Yamazaki::Torrent

  describe '#new' do
    context 'with default arguments' do
      it 'is created correctly' do
        #(title, description, pub_date, link, index = 0, filename="")
        torrent = Yamazaki::Torrent.new("Kyoukaisen", "10/10 would watch again",
                        "2015/10/13 21:42:33", "https://just-believe.in")

        expect(torrent.title).to eq("Kyoukaisen")
        expect(torrent.pub_date).to eq("2015/10/13 21:42:33")
        #test defaults
        expect(torrent.index).to eq(0)
        expect(torrent.filename).to eq("")
      end

    context 'default arguments are given a value'
      it 'sets filename correctly at torrent creation' do
        torrent = Yamazaki::Torrent.new("The Rolling Girls", ">Kyoto arc", "2015/10/13 21:42:33",
                                         "http://u.rl", 15, "/home/roxas/trg.torrent")
        expect(torrent.filename).to eq("/home/roxas/trg.torrent")
      end

      it 'creates a torrent with a positive or zero index' do
        torrent = Yamazaki::Torrent.new("aaa", "bbb", "2015/10/13 21:42:33", "http://u.rl", 3)
        expect(torrent.index).to eq(3)
      end

#      it 'raises ArgumentError with a negative index' do
#        expect {
#          Yamazaki::Torrent.new("ccc", "ddd", "2016/01/18 18:43:29", "https://u.rl", -5)
#        }.to raise_error(ArgumentError) 
#      end
    end

  describe '#filename'
    context 'filename setting in a torrent' do
      it 'is set correctly after torrent creation' do
         thor = Yamazaki::Torrent.new("Roxas the Animu", "10/10 would watch again",
                       "2015/10/13 21:42:33", "https://just-believe.in")
         expect {
           thor.filename = "/home/roxas/.watch/Roxas_s1_ep1_[ABAB65][CR].torrent"
         }.not_to raise_error()
       
         expect(thor.filename).to eq("/home/roxas/.watch/Roxas_s1_ep1_[ABAB65][CR].torrent")
      end
    end
  end
end
