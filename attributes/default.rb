#
# Cookbook Name:: duplicity_ng
# Attributes:: default
#
# Copyright (C) 2014 Chris Aumann
# Copyright (C) 2014 Alexander Merkulov
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Path to duplicity executeable
default['duplicity_ng']['path'] = '/usr/bin/duplicity'

# Path where duplicity configuration (credential environment variables, etc) are stored
default['duplicity_ng']['confdir'] = value_for_platform_family(
  'debian' => '/etc/default',
  'rhel' => '/etc/sysconfig',
  'default' => '/etc',
)

# Set this to true to use pip to install duplicity dependencies
default['duplicity_ng']['use_pip'] = false

# Variables for installing duplicity from source
default['duplicity_ng']['source']['checksum'] = '1d41d756638f55106f9501c3db94ccbc6568aa856ba531e07ed2cfb760b62450'
default['duplicity_ng']['source']['version'] = '0.6.24'
default['duplicity_ng']['source']['url'] = "https://launchpad.net/duplicity/0.6-series/#{node['duplicity_ng']['source']['version']}/+download/duplicity-#{node['duplicity_ng']['source']['version']}.tar.gz" # rubocop:disable Metrics/LineLength

default['duplicity_ng']['source']['gnupg']['version'] = '0.3.2'
default['duplicity_ng']['source']['gnupg']['url'] = "http://switch.dl.sourceforge.net/project/py-gnupg/GnuPGInterface/#{node['duplicity_ng']['source']['gnupg']['version']}/GnuPGInterface-#{node['duplicity_ng']['source']['gnupg']['version']}.tar.gz" # rubocop:disable Metrics/LineLength
default['duplicity_ng']['source']['gnupg']['checksum'] = '0ea672251e2e3f71b62fef0c01539519d500f6b338f803af6b57e67a73cca8e6'

default['duplicity_ng']['source']['azure']['version'] = '0.9.0'
default['duplicity_ng']['source']['azure']['url'] = "https://github.com/Azure/azure-sdk-for-python/archive/v#{node['duplicity_ng']['source']['azure']['version']}.tar.gz" # rubocop:disable Metrics/LineLength
default['duplicity_ng']['source']['azure']['checksum'] = 'aaeb8d7a8fa0d819caf7d6a89d592cf5dc68f21e401e216141c0567c809cd3b7'

case node['platform_family']
when 'debian'
  default['duplicity_ng']['source']['dev']['packages'] = %w(python-dev librsync-dev)
  default['duplicity_ng']['source']['python']['packages'] = %w(python-lockfile python-setuptools python-gnupginterface python-paramiko)
when 'rhel', 'fedora', 'suse'
  # Use pip by default on rhel, as the packages are outdated
  default['duplicity_ng']['use_pip'] = true
  default['duplicity_ng']['source']['dev']['packages'] = %w(python-devel librsync-devel)
  default['duplicity_ng']['source']['python']['packages'] = %w(python-lockfile python-setuptools python-GnuPGInterface python-paramiko)
end
