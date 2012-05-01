require 'spec_helper'

module Nwiki
  module Core
    describe Page do
      subject { described_class.new(BlobEntry.new(sha, path)) }
      let(:sha) { 'bda3255f29e545c6a9fa73f2fc8aa40b2f531ce3' }
      let(:path) { 'foo.org' }

      describe '#filename' do
        its(:filename) { should eq path }
      end

      describe '#name' do
        its(:name) { should eq File.basename(path, '.*') }
      end
    end
  end
end
