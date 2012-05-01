require 'spec_helper'

module Nwiki
  module Core
    describe Wiki do
      shared_context 'when uses empty.git' do
        subject { described_class.new('spec/examples/empty.git') }
      end
      describe '.new' do
        context 'when uses empty.git' do
          include_context 'when uses empty.git'
          it { expect { subject }.not_to raise_error }
        end
      end
      describe '#pages' do
        context 'when uses empty.git' do
          include_context 'when uses empty.git'
          its(:pages) { should eq [] }
        end
      end
      describe '#page' do
        context 'when uses empty.git' do
          include_context 'when uses empty.git'
          it { subject.page('foo').should be_nil }
        end
      end
    end
  end
end
