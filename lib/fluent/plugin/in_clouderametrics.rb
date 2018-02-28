#
# Copyright 2018- Wesley Yao
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

require "fluent/plugin/input"
require "uri"
require "json"

module Fluent
  module Plugin
    class ClouderametricsInput < Fluent::Plugin::Input
      # Register plugin. NAME is the name of this plugin
      # and it identifes the plugin in the config file
      Fluent::Plugin.register_input("clouderametrics", self)
 
      config_param :timespan,           :integer, :default => 300
      config_param :user,               :string,  :default => "user"
      config_param :pass,               :string,  :default => "pass"

      def watch
        log.debug "cloudera metrics: watch thread starting"
        @next_fetch_time = Time.now
    
        until @finished
            start_time = @next_fetch_time - @timespan
            end_time = @next_fetch_time
    
            log.debug "start time: #{start_time}, end time: #{end_time}"
    
            # monitor_metrics_promise = get_monitor_metrics_async(start_time, end_time)
            # monitor_metrics = monitor_metrics_promise.value!
    
            #router.emit(@tag, Time.now.to_i, monitor_metrics.body['value'])
            @next_fetch_time += @timespan
            sleep @timespan
        end
      end

      # Called before starting
      def configure(conf)
        super
      end

      def start
        super
      end

      def shutdown
        super
      end
    end
  end
end
