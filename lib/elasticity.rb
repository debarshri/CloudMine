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
 ONE_LOCATION=ENV["ONE_LOCATION"]
  
  if !ONE_LOCATION
      RUBY_LIB_LOCATION="/usr/lib/one/ruby"
      else
          RUBY_LIB_LOCATION=ONE_LOCATION+"/lib/ruby"
          end
           
           $: << RUBY_LIB_LOCATION
            
          require 'OpenNebula'             
          include OpenNebula

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
            # OpenNebula credentials
              CREDENTIALS = $credentials
            # XML_RPC endpoint where OpenNebula is listening
              ENDPOINT    = $endpoint

LOAD_TEMP_PATH = $path+"/lib/"
$: << LOAD_TEMP_PATH

require 'ACL'
require 'initVM'

gateKeeper = ACL.new()
check = gateKeeper.check(ARGV[0],ARGV[1])
if check == 1 
then
 xml = OpenNebula::VirtualMachine.build_xml

               client = Client.new(CREDENTIALS, ENDPOINT)

vm_pool = VirtualMachinePool.new(client, -1)

rc = vm_pool.info
if OpenNebula.is_error?(rc)
     puts "ERROR:"+rc.message
     exit -1
end

$Konst = 0
$Pool_count = 3
vm_pool.each do |vm|
     $Konst += 1
end


File.open($path+'/conf/cloud_env', 'r') do |f1|
  while line = f1.gets
	if(line.split("=").first == "POOL_SIZE")
	then
$Pool_count = line.split("=").last.split("\n").first.to_i
	end
end
end
$Kount = 0
 if($Pool_count > $Konst)
                then
	while($Pool_count-$Konst != $Kount)
                
               kreator = VMinit.new
                kreator.create
		$Kount = $Kount + 1

        end
elsif( $Pool_count < $Konst)
 then
    vm_pool.each do |vm|
	rc = vm.shutdown
	$Kount += 1
	if OpenNebula.is_error?(rc)
		puts "Virtual Machine #{vm.id}: #{rc.message}"
	else
         File.open($path+'/conf/.removed', 'a') do |f2|
                       f2.write("#{vm.id.to_s}\n")
                end
                 
  		 puts "Virtual Machine #{vm.id}: Shutting down"
 	end
	
   if($Konst - $Pool_count == $Kount)
	 then
	   exit(0)
	end
	
    end
else
  
   puts "\nNo changes-change conf/cloud_env for adjusting pool size\n"

 end
else
puts "Credentials please..."
 end

