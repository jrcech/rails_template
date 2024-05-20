require 'rails_helper'

RSpec.describe Tables::TableComponent, type: :component do
  let(:table) { build(:table) }

  describe 'factory' do
    it 'is valid' do
      expect(table).to be_an_instance_of(described_class)
    end
  end

  it 'renders a base table' do
    render_inline table

    aggregate_failures do
      expect_to_have_css_attributes base_table_css
    end
  end

  context 'with head' do
    let(:table) { build(:table, :with_head) }

    it 'renders a table with head' do
      render_inline table

      aggregate_failures do
        expect_to_have_css_attributes table_with_head_css
      end
    end
  end

  context 'with show path' do
    let(:table) { build(:table, :with_show_path) }

    it 'renders a table with show path' do
      render_inline table

      aggregate_failures do
        expect_to_have_css_attributes table_with_show_path_css
      end
    end
  end

  private

  def base_table_css
    [
      'table.table > tbody > tr:first-child > td:nth-child(2)',
      'table.table > tbody > tr:nth-child(2) > td:nth-child(2)'
    ]
  end

  def table_with_head_css
    [
      'table.table > thead > tr:first-child > th:nth-child(2)',
      'table.table > thead > tr:nth-child(2) > th:nth-child(2)',
      'th[scope="col"]',
      'table.table > tbody > tr:first-child > td:nth-child(2)',
      'table.table > tbody > tr:nth-child(2) > td:nth-child(2)'
    ]
  end

  def table_with_show_path_css
    [
      'table.table > tbody > tr[data-controller="index-table"]:nth-child(2) > td',
      'tr[data-action="click->index-table#visit"]',
      'tr[data-index-table-link="show_path_1"]:first-child',
      'tr[data-index-table-link="show_path_2"]:nth-child(2)'
    ]
  end
end
