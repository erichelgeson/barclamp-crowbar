#!/usr/bin/ruby
# Copyright 2011, Dell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Author: RobHirschfeld
#

  # the 1st choice is to use the code from the framework since it is most up to date
  # however, that code is not always available when installing
  fw_lib = File.join '/opt', 'dell', 'crowbar_framework', 'lib', 'barclamp_lib'
  if File.exists? fw_lib+'.rb'
    require fw_lib
  else
    require File.join '/opt', 'dell', 'barclamps', 'crowbar', 'crowbar_framework', 'lib', 'barclamp_lib'
  end

  # this is used by the install-chef installer script 
  if __FILE__ == $0
    bc = ARGV[0]
    org = ARGV[1] || "Dell, Inc."
    path = ARGV[2] || "/opt/dell/barclamps"
    target = File.join path, bc
    
    if bc.nil? or bc == ""
      puts "You must supply a name to create a barclamp"
      exit -3
    elsif File.exist? File.join target, "crowbar.yml"
      puts "Aborting! A barclamp already exists in '#{target}'."
      exit -3
    elsif ! ( bc =~ /^[a-zA-Z0-9_]*$/ )
      puts "You must supply a name to create a barclamp"
      exit -3
    else
      puts "Creating barclamp '#{bc}' into '#{path}' as entity '#{org}'."
      files = []
      FileUtils.mkdir target
      clone = Dir.entries(MODEL_SOURCE).find_all { |e| !e.start_with? '.'}
      clone.each do |item|
        files += bc_cloner(item, bc, org, MODEL_SOURCE, target, true)
      end
      filelist = "#{bc}-filelist.txt"
      File.open( filelist, 'w' ) do |out|
        files.each { |line| out.puts line } 
      end
      puts "Barclamp #{bc} created in #{target}.  Review #{filelist} for files created."
    end
    
    exit 0
    
  end  
