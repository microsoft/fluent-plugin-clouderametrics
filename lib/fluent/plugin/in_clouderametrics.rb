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
require 'net/http'

module Fluent
  module Plugin
    class ClouderametricsInput < Fluent::Plugin::Input
      # Register plugin. NAME is the name of this plugin
      # and it identifes the plugin in the config file
      Fluent::Plugin.register_input("clouderametrics", self)
 
      # To support log_level option implemented by Fluentd v0.10.43
      unless method_defined?(:log)
        define_method("log") { $log }
      end

      config_param :host,               :string,  :default => "http://localhost"
      config_param :port,               :integer, :default => "7180"
      config_param :api_version,        :string,  :default => "v19"
      config_param :api_endpoint,       :string
      config_param :query,              :string

      config_param :user,               :string,  :default => "user"
      config_param :pass,               :string,  :default => "pass"

      config_param :timespan,           :integer, :default => 2
      config_param :tag,                :string,  :default => "cloudera.metrics"

      def watch
        log.debug "cloudera metrics: watch thread starting"
        @next_fetch_time = Time.now
    
        until @finished
            start_time = @next_fetch_time - @timespan
            end_time = @next_fetch_time
    
            log.debug "start time: #{start_time}, end time: #{end_time}"

            body = get_cloudera_metrics

            log.debug body
            
            router.emit @tag, Fluent::Engine.now, body

            @next_fetch_time += @timespan
            sleep @timespan
        end
      end
      
      def get_cloudera_metrics
        uri = URI(@manager_uri)
        log.debug uri

        req = Net::HTTP::Get.new(uri)
        req.basic_auth @user, @pass

        res = Net::HTTP.start(uri.hostname, uri.port) {|http|
          http.request(req)
        }

        log.debug res.code
        log.debug res.message

        res.body
      end

      # Called before starting
      def configure(conf)
        super
        log.debug "configure"
        @manager_uri = "#{host}:#{port}/api/#{api_version}/#{api_endpoint}?query=#{query}"
      end

      def start
        super
        log.debug "start"
        @watcher = Thread.new(&method(:watch))
      end

      def shutdown
        super
        log.debug "shutdown"
        @watcher.terminate
        @watcher.join
      end
    end
  end
end
