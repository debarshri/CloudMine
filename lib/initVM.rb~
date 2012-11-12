#!/usr/bin/env ruby
## Copyright 2012, Debarshi Basak (D.Basak@student.tudelft.nl)
##
##   Licensed under the Apache License, Version 2.0 (the "License");
##   you may not use this file except in compliance with the License.
##   You may obtain a copy of the License at
##
##       http://www.apache.org/licenses/LICENSE-2.0
##
##   Unless required by applicable law or agreed to in writing, software
##   distributed under the License is distributed on an "AS IS" BASIS,
##   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##   See the License for the specific language governing permissions and
##   limitations under the License.
##
class VMinit
 ONE_LOCATION=ENV["ONE_LOCATION"]

  if !ONE_LOCATION
      RUBY_LIB_LOCATION="/usr/lib/one/ruby"
      else
          RUBY_LIB_LOCATION=ONE_LOCATION+"/lib/ruby"
  end

           $: << RUBY_LIB_LOCATION

            require 'OpenNebula'
             
             include OpenNebula
              
              # OpenNebula credentials
$path = ENV['PROJECT_CLOUD']
$credentials
$endpoint
File.open($path+'/conf/cloud_env', 'r') do |f1|
  while line = f1.gets
        if(line.split("=").first == "CLOUD_PASS")
        then
$credentials = line.split("=").last.split("\n").to_s
        end
if(line.split("=").first == "END_POINT")
        then
$endpoint = line.split("=").last.split("\n").to_s
        end

end
end

        #OpenNebula credentials
                      CREDENTIALS = $credentials
        # XML_RPC endpoint where OpenNebula is listening
                  ENDPOINT    = $endpoint
                                                  
def create()
                                                
$description = ""
               client = Client.new(CREDENTIALS,ENDPOINT)
File.open($path+'/conf/image_conf', 'r') do |f1|
  while line = f1.gets
$description = $description + line.to_s
end
end
                xml = OpenNebula::VirtualMachine.build_xml               
                vm = OpenNebula::VirtualMachine.new(xml, client)
                 
                rc = vm.allocate($description)
                if OpenNebula.is_error?(rc)
                     puts rc.message
                          exit -1
                else 
		    puts "Starting VM #{vm.id.to_s}"
	            File.open($path+'/conf/.nodes', 'a') do |f2|  
                    f2.write("#{vm.id.to_s}\n")
  		end
    	   end
end
end

