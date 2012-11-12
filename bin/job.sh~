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
touch task.log
JOB_DATE=`date "+%H:%M:%S:%N"`
if [ -d $1 ]
then
temp_loc=$2
actual_loc=$(basename "$temp_loc")
echo "TASK_ID=$JOB_DATE,$3,`cat $actual_loc|grep $3|wc -l`" >> $1/$1-"`date "+%Y%m%d%H%M%S"`".result
else
mkdir $1
fi
JOB_DATE2=`date "+%H:%M:%S:%N"`
echo "TASK_ID=$1_$JOB_DATE,started=$JOB_DATE,ended=$JOB_DATE2" >> task.log
