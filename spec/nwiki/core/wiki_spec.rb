require 'spec_helper'

module Nwiki
  module Core
    describe Wiki do
      subject { described_class.new('any_file_path') }
      it { expect { subject }.not_to raise_error }
    end
  end
end
