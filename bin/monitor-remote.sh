# Copyright 2012, Debarshi Basak D.Basak@student.tudelft.nl
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
while true 
do
touch vm_stat_project_cloud
COLLDATE=`date "+%Y-%m-%d %H:%M:%S"`
CPU=(`cat /proc/stat | grep '^cpu '`)
PROCS=`cat /proc/stat | grep '^processes' | cut -d' ' -f2`
CONTXT=`cat /proc/stat | grep '^ctxt' | cut -d' ' -f2`
R_PROCS=`cat /proc/stat | grep '^procs_running' | cut -d' ' -f2`
unset CPU[0]                     
IDLE=${CPU[4]}
TOTAL=0
  for VALUE in "${CPU[@]}"; do
    let "TOTAL=$TOTAL+$VALUE"
  done
  let "DIFF_USAGE=(100*($TOTAL-$IDLE)/$TOTAL)"

IMEM=`free|grep '^Mem'`
TOTAL_MEM=$(echo $IMEM | cut -d' ' -f2)
FREE_MEM=$(echo $IMEM | cut -d' ' -f3)
CACHED_MEM=$(echo $IMEM | cut -d' ' -f7)
MEM=`expr $TOTAL_MEM - $FREE_MEM`
echo "DATE=$COLLDATE,CPU=$DIFF_USAGE%,TOTAL_NUM_PROCS=$PROCS,RUNNING_PROCS=$R_PROCS,CONTXT_SWITCHING=$CONTXT,USED_MEM=$MEM,AVAIL_MEM=$FREE_MEM,TOTAL_MEM=$TOTAL_MEM,CACHED_MEM=$CACHED_MEM" >> vm_stat_project_cloud
sleep 5
done
