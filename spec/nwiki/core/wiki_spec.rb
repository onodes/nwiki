# -*- coding: utf-8 -*-
require 'spec_helper'

module Nwiki
  module Core
    describe Wiki do
      shared_context 'when uses empty.git' do
        # repository denote by `tree` command
        # '.'
        subject { described_class.new('spec/examples/empty.git') }
      end

      shared_context 'when uses has_foo.git' do
        # repository denote by `tree` command
        # '.'
        # '└── foo'
        subject { described_class.new('spec/examples/has_foo.git') }
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
          its(:pages) { should be_empty }
        end

        context 'when uses has_foo.git' do
          include_context 'when uses has_foo.git'
          its(:pages) { should have(1).page }
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
