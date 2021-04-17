require 'spec_helper'

describe 'teams' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) { 'include apt' }

      it { is_expected.to compile.with_all_deps }
      it {
        is_expected.to contain_apt__key('microsoft').with(
          'id'     => 'BC528686B50D79E339D3721CEB3E94ADBE1229CF',
          'source' => 'https://packages.microsoft.com/keys/microsoft.asc',
        )
      }
      it {
        is_expected.to contain_apt__source('teams').with(
          'location'     => 'https://packages.microsoft.com/repos/ms-teams',
          'architecture' => 'amd64',
          'release'      => 'stable',
          'repos'        => 'main',
        )
      }
      it { is_expected.to contain_package('teams').with('require' => 'Apt::Source[teams]') }
    end
  end
end
