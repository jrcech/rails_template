require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= class_name %>, <%= type_metatag(:model) %> do
  it 'has a valid factory' do
    expect(FactoryBot.build(:<%= class_name.underscore %>)).to be_valid
  end
end
<% end -%>
