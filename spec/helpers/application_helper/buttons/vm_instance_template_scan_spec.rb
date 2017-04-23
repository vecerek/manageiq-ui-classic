require 'shared/helpers/application_helper/buttons/basic'

describe ApplicationHelper::Button::VmInstanceTemplateScan do
  include_context 'ApplicationHelper::Button::Basic'
  let(:sandbox) { Hash.new }
  let(:instance_data) { {'record' => record} }
  let(:props) { Hash.new }
  let(:record) { FactoryGirl.create(:vm_or_template) }

  describe '#visible?' do
    let(:has_proxy?) { true }
    before do
      allow(record).to receive(:supports?).with(:smartstate_analysis).and_return(supports_feature?)
      allow(record).to receive(:has_proxy?).and_return(has_proxy?)
    end

    context 'when record supports smartstate analysis' do
      let(:supports_feature?) { true }
      context 'when record has proxy' do
        include_examples 'ApplicationHelper::Button::Basic#visible?', true
      end
      context 'when record does not have proxy' do
        let(:has_proxy?) { false }
        include_examples 'ApplicationHelper::Button::Basic#visible?', false
      end
    end
    context 'when record does not support smartstate analysis' do
      let(:supports_feature?) { false }
      include_examples 'ApplicationHelper::Button::Basic#visible?', false
    end
  end

  describe '#calculate_properties' do
    let(:has_active_proxy?) { true }
    before do
      MiqServer.seed
      allow(record).to receive(:has_active_proxy?).and_return(has_active_proxy?)
    end

    it_behaves_like 'a smart state scan button'

    context 'when smart_roles are enabled' do
      before do
        roles = %w(smartproxy smartstate).collect { |role| FactoryGirl.create(:server_role, :name => role) }
        FactoryGirl.create(:miq_server, :zone => MiqServer.my_server.zone, :active_roles => roles)
        subject.calculate_properties
      end

      context 'when record has active proxy' do
        include_examples 'ApplicationHelper::Button::Basic enabled'
      end
      context 'when record does not have active proxy' do
        let(:has_active_proxy?) { false }
        include_examples 'ApplicationHelper::Button::Basic disabled', 'No active SmartProxies found to analyze this VM'
      end
    end
  end
end
