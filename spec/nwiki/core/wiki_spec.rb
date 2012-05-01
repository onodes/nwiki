require 'spec_helper'

module Nwiki
  module Core
    describe Wiki do
      subject { described_class.new('spec/examples/empty.git') }
      it { expect { subject }.not_to raise_error }
      its(:pages) { should eq [] }
      it { subject.page('foo').should be_nil }
    end
  end
end
