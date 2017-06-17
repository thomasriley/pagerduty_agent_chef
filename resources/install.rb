=begin
#<
Install the PagerDuty agent.
#>
=end

property :repo_yum_base_url, String, default: 'https://packages.pagerduty.com/pdagent/rpm'
property :repo_yum_enabled, Integer, default: 1
property :repo_yum_gpgcheck, Integer, default: 1
property :repo_yum_gpg_key, String, default: 'https://packages.pagerduty.com/GPG-KEY-RPM-pagerduty'

default_action :create

action :create do
  template '/etc/yum.repos.d/pdagent.repo' do
    source 'pdagent.repo.erb'
    owner 'root'
    group 'root'
    mode '0644'
    cookbook 'pagerduty_agent'
    variables(
        repo_base_url: repo_yum_base_url,
        repo_enabled: repo_yum_enabled,
        repo_gpgcheck: repo_yum_gpgcheck,
        repo_gpg_key: repo_yum_gpg_key
    )
  end

  package %w(pdagent pdagent-integrations) do
    action :install
    notifies :restart, 'service[pdagent]', :delayed
  end

  service 'pdagent' do
    supports :status => true, :restart => true, :reload => true
    action [:start, :enable]
  end
end