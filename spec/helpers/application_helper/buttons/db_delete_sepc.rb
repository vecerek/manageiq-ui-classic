require 'shared/helpers/application_helper/buttons/basic'

describe ApplicationHelper::Button::DbDelete do
  include_context 'ApplicationHelper::Button::Basic'
  let(:sandbox) { Hash.new }
  let(:instance_data) { {'db' => dashboard} }
  let(:props) { Hash.new }
  let(:dashboard) { FactoryGirl.create(:miq_widget_set, :read_only => read_only) }

  describe '#calculate_properties' do
    before { subject.calculate_properties }

    context 'when dashboard is read-only' do
      let(:read_only) { true }
      it_behaves_like 'a disabled button', 'Default Dashboard cannot be deleted'
    end
    context 'when dashboard is writable' do
      let(:read_only) { false }
      it_behaves_like 'an enabled button'
    end
  end
end
