# fluent-plugin-clouderametrics
[![Gem Version](https://badge.fury.io/rb/fluent-plugin-clouderametrics.svg)](https://badge.fury.io/rb/fluent-plugin-clouderametrics)

[Fluentd](https://fluentd.org/) input plugin for cloudera metrics.

Cloudera metrics plugin queries for cloudera cluster metrics and is easily configurable so that you can pull the metrics you want.

[Cloudera Manager APIs](https://cloudera.github.io/cm_api/apidocs/v19/index.html/) provides documentation on how to use each api.

## Installation

### RubyGems

```
$ gem install fluent-plugin-clouderametrics
```

## Configuration

```
<source>
  @type        clouderametrics
  tag          tagname                          (default: cloudera.metrics)
  timespan     60                               (default: 60) [seconds]
  user         username                         (default: user)
  pass         password                         (default: password)
  host         http://cloudera-host.com         (default: http://localhost)
  port         7180                             (default: 7180)
  api_version  v19                              (default: v19)
  api_endpoint timeseries
  query        select+*+where+roletype=DATANODE (default: "")
</source>

```

### Sample Configuration

```
<source>
  @type clouderametrics
  tag azure.cloudera
  timespan 10
  user username
  pass password
  host http://test-cloudera-mn0.westus.cloudapp.azure.com
  port 7180
  api_endpoint hosts
  api_version v17
  query select+cpu_user_rate+where+roletype=DATANODE
</source>
```

## Test

Run tests:

```
$ rake test
```

## Copyright

* Copyright(c) 2018- Wesley Yao & Zach Miller
* License
  * MIT
