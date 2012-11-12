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
class ACL
def check(username,password)
path = ENV['PROJECT_CLOUD']
File.open(path+'/conf/.acl/acl', 'r') do |f1|  
  while line = f1.gets  
if(line.split(",").first == username)
then
    userDet = line.split(",")
    passDet = userDet[1].split("\n")
    
   if (username == userDet[0]) 
    then
     if(password == passDet[0]) 
       then
       return 1
    else
   puts "Either the username or password is wrong" 
exit(0)
return 0
     end 
  else
   puts "Either Wrong password or username"
    exit(0)
return 0
     end
  end  
end
end
end
end
