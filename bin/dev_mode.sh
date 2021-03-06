#!/bin/bash
# Copyright 2011, Dell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# clean up
service crowbar stop
pidof rainbows

# start dev version of the server
cd /opt/dell/crowbar_framework/
chmod 777 -R .
if which rainbows &> /dev/null; then
  rainbows -d -E development -c rainbows-dev.cfg
else
  # still needed for ubuntu
  /var/lib/gems/1.8/bin/rainbows -d -E development -c rainbows-dev.cfg
fi


