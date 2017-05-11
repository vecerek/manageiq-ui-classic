require 'shared/helpers/application_helper/buttons/vm_console'

describe ApplicationHelper::Button::VmVmrcConsole do
  include_context 'ApplicationHelper::Button::Basic'
  let(:sandbox) { Hash.new }
  let(:instance_data) { {'record' => record} }
  let(:props) { Hash.new }
  let(:record) { FactoryGirl.create(:vm_vmware) }

  describe '#visible?' do
    include_context 'ApplicationHelper::Button::VmConsole#visible?',
                    :console_type       => 'VMRC',
                    :support_of_records => {:vm_openstack => false, :vm_redhat => false, :vm_vmware => true}
  end

  describe '#calculate_properties' do
    before do
      remote_console_validation
      subject.calculate_properties
    end

    context 'and remote control is supported' do
      let(:remote_console_validation) do
        allow(record).to receive(:validate_remote_console_vmrc_support).and_return(true)
      end
      include_examples 'ApplicationHelper::Button::Basic enabled'
    end
    context 'and remote control is not supported' do
      let(:err_msg) { 'Remote console is not supported' }
      let(:remote_console_validation) do
        allow(record).to receive(:validate_remote_console_vmrc_support)
          .and_raise(MiqException::RemoteConsoleNotSupportedError, err_msg)
      end
      include_examples 'ApplicationHelper::Button::Basic disabled',
                       :error_message => 'VM VMRC Console error: Remote console is not supported'
    end
  end
end
