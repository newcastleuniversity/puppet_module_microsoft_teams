require 'spec_helper'

describe 'teams' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_file('teams.deb').with('source' => 'puppet:///modules/teams/teams_1.2.00.32451_amd64.deb') }
      it { is_expected.to contain_package('teams').with('provider' => 'dpkg') }
    end
  end
end
