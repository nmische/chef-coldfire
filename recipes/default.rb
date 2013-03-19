#
# Cookbook Name:: coldfire
# Recipe:: default
#
# Copyright 2012, NATHAN MISCHE
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Install necessary packages

package "unzip" do
  action :install
end

# Download ColdFire

remote_file "#{Chef::Config['file_cache_path']}/coldfire.zip" do
  owner "root"
  group "root"
  mode 00644
  source node['coldfire']['download_url']
end

# Extract debugging template

execute "install_coldfire_debug_template" do
  command <<-COMMAND
    unzip coldfire.zip -d coldfire
    cp coldfire/coldfusion/debug/coldfire.cfm #{node['cf10']['installer']['install_folder']}/cfusion/wwwroot/WEB-INF/debug
  COMMAND
  cwd Chef::Config['file_cache_path']
  action :run
  not_if { File.exists?("#{node['cf10']['installer']['install_folder']}/cfusion/wwwroot/WEB-INF/debug/coldfire.cfm") }
end

# Configure debugging settings via admin API

execute "start_cf_for_coldfire_cf_config" do
  command "/bin/true"
  notifies :start, "service[coldfusion]", :immediately
end

coldfusion902_config "set_colfire_debugging" do
  action :bulk_set
  config ( { 
      "debugging" => { 
          "debugProperty" => [ 
              {"propertyName" => "enableDebug", "propertyValue" => true },
              {"propertyName" => "debugTemplate", "propertyValue" => "coldfire.cfm" }
         ]
      }
    } )
end

coldfusion902_config "debugging" do
  action :set
  property "IP"
  args ( { "debugip" => node['coldfire']['ip_list'] } )
  only_if { node['coldfire']['ip_list'] }
end





