# frozen_string_literal: true

RSpec.describe Hanamimastery::Utils::Pagination do
  let(:pagination_reader_class) do
    Class.new do
      include Hanamimastery::Utils::Pagination::Reader

      def call = pagination
    end
  end

  let(:pagination_reader) { pagination_reader_class.new }

  let(:paginatable) do
    Class.new do
      include Hanamimastery::Utils::Pagination

      def call(params)
        paginate(params) { pagination_reader.new.call }
      end
    end
  end

  subject { paginatable.new }

  describe '#paginate' do
    let(:params) { { page: { number: 3, size: 4 } } }

    it 'returns the pagination object' do
      pagination = subject.paginate(params) { pagination_reader.call }
      expect(pagination.number).to eq(3)
      expect(pagination.size).to eq(4)
    end

    it 'calls the #detect_page' do
      expect(subject).to receive(:detect_page).with(params)

      subject.paginate(params) { pagination_reader.call }
    end

    it 'calling reader without setter raises the error' do
      expect { pagination_reader.call }.to raise_error(Hanamimastery::Utils::Pagination::PaginationUnsetError)
    end
  end

  describe '#detect_page' do
    it 'works for correct hash' do
      params = { page: { number: 3, size: 4 } }
      result = subject.detect_page(params)
      expect(result.number).to eq(3)
      expect(result.size).to eq(4)
    end

    it 'works for stringified hash' do
      params = { 'page' => { 'number' => 3, 'size' => 4 } }
      result = subject.detect_page(params)
      expect(result.number).to eq(3)
      expect(result.size).to eq(4)
    end

    it 'works for empty hash' do
      params = {}
      result = subject.detect_page(params)
      expect(result.number).to eq(1)
      expect(result.size).to eq(10)
    end

    it 'sets defaults for missing keys' do
      params = { 'page' => {} }
      result = subject.detect_page(params)
      expect(result.number).to eq(1)
      expect(result.size).to eq(10)
    end

    it 'fails for incorrect values' do
      params = { 'page' => { 'number' => -1, 'size' => 0 } }
      expect { subject.detect_page(params) }.to raise_error(described_class::PaginationParamsError)
    end

    describe 'PaginationType' do
      let(:type) { described_class::PaginationType }

      it 'uses correct type coercion' do
        aggregate_failures do
          params = { page: { number: 3, size: 4 } }
          expect(type[params]).to eq({ page: { number: 3, size: 4 } })

          params = { 'page' => { 'number' => 3, 'size' => 4 } }
          expect(type[params]).to eq({ page: { number: 3, size: 4 } })

          params = { 'page' => {} }
          expect(type[params]).to eq({ page: { number: 1, size: 10 } })

          params = {}
          expect(type[params]).to eq({ page: { number: 1, size: 10 } })

          params = { 'page' => { 'number' => -1, 'size' => 0 } }
          expect { type[params] }.to raise_error(Dry::Types::SchemaError)
        end
      end
    end
  end
end
