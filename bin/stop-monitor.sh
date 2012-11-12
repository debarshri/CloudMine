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

touch mon_proc
echo `ps -aef| grep monitor` >> mon_proc
kill -9 `head -n 1 mon_proc|cut -d' ' -f2`
rm mon_proc
