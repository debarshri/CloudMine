# Copyright 2012, Debarshi Basak(D.Basak@student.tudelft.nl)
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

COUNT=`cat $PROJECT_CLOUD/conf/.monitor|wc -l`
while [ $COUNT -gt 0 ]
do
VM_ID=$(head -n 1 $PROJECT_CLOUD/conf/.monitor)
sed -i 1d $PROJECT_CLOUD/conf/.monitor
echo $VM_ID >> $PROJECT_CLOUD/conf/.monitor
echo "clearing logs $VM_ID"
COUNT=`expr $COUNT - 1`
VM_IP=`ruby $PROJECT_CLOUD/lib/headnode.rb $VM_ID`
echo "`scp $PROJECT_CLOUD/bin/clear-log.sh opennebula@$VM_IP:/home/opennebula`" >>  $PROJECT_CLOUD/logs/sys.log
echo "`ssh opennebula@$VM_IP 'bash -i' /home/opennebula/clear-log.sh `" >> $PROJECT_CLOUD/logs/sys.log
done

