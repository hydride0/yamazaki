require_relative 'spec_helper'

describe Yamazaki::Core do
  include Yamazaki::Core

  describe '#list' do
    context 'no params are given' do
      let(:torrents) { list }

      # TODO: consider n=10 by default
      it 'returns an empty array of torrents' do
        expect(torrents).to be_an(Array)
        expect(torrents).to be_empty
      end
    end

    context 'a limit for results is given' do
      let(:torrents) { list(2) }

      it 'returns an array containing 2 torrents' do
        expect(torrents).to      be_an(Array)
        expect(torrents.size).to be 2
      end
    end
  end

  describe '#search' do
    context 'empty string is given' do
      it 'returns an ArgumentError exception' do
        expect { search('') }.to raise_error(ArgumentError)
      end
    end

    context 'given parameter is not a string' do
      it 'returns an ArgumentError exception' do
        expect { search(nil) }.to raise_error(ArgumentError)
      end
    end

    context 'keyword is given' do
      let(:torrents) { search('Nisekoi') }

      it 'returns a not-empty array of torrents' do
        expect(torrents).to     be_an(Array)
        expect(torrents).to_not be_empty
      end
    end
  end
end
