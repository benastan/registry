require 'spec_helper'

describe Registry do
  describe '#register' do
    subject { Registry.new }

    let(:b) { ->{} }

    before do
      subject.register(:a)
      subject.register(:b, 'a')
      subject.register(:c, 'a', 'b')
      subject.register(:d, 'a', &b)
    end

    specify { expect(subject[:a]).to eq nil }
    specify { expect(subject[:b]).to eq 'a' }
    specify { expect(subject[:c]).to eq [ 'a', 'b' ] }
    specify { expect(subject[:d]).to eq [ 'a', b ] }
  end

  describe 'kernel method' do
    subject { Class.new{Registry(self)}}
    let(:registry){{}}
    let(:block){->{}}
    
    describe '#register' do
      before do
        allow(registry).to receive(:register).and_return(nil)
        subject.stub(registry: registry)
      end

      it 'delegates to .registry' do
        subject.register('blah', &block)
        expect(registry).to have_received(:register).with('blah', &block)
      end
    end
    
    describe '.registry' do
      specify do
        expect(subject.registry).to be_a(Registry)
      end
    end

    describe '.reset!' do
      before{subject.register(:blah, 'blah')}

      specify do
        expect{subject.reset!}.to change{subject.registry[:blah]}.from('blah').to(nil)
      end
    end
  end
end
