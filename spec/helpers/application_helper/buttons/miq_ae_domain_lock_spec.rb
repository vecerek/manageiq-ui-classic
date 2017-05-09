require 'shared/helpers/application_helper/buttons/basic'

describe ApplicationHelper::Button::MiqAeDomainLock do
  include_context 'ApplicationHelper::Button::Basic'
  let(:sandbox) { Hash.new }
  let(:instance_data) { {'record' => record} }
  let(:props) { Hash.new }

  describe '#visible?' do
    context 'when domain locked by user' do
      let(:record) { FactoryGirl.create(:miq_ae_domain_user_locked) }
      include_examples 'ApplicationHelper::Button::Basic hidden'
    end
    context 'when domain lockable but edit not possible' do
      let(:record) { FactoryGirl.create(:miq_ae_domain) }
      include_examples 'ApplicationHelper::Button::Basic visible'
    end
  end
end
