require 'shared/helpers/application_helper/buttons/basic'

describe ApplicationHelper::Button::MiqCapacity do
  include_context 'ApplicationHelper::Button::Basic'
  let(:sandbox) { {:active_tab => tab} }
  let(:instance_data) { Hash.new }
  let(:props) { Hash.new }

  describe '#visible?' do
    context 'when active_tab is report' do
      let(:tab) { 'report' }
      include_examples 'ApplicationHelper::Button::Basic visible'
    end
    context 'when active_tab is not report' do
      let(:tab) { 'not_report' }
      include_examples 'ApplicationHelper::Button::Basic hidden'
    end
  end
end
