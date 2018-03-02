# fluent-plugin-clouderametrics

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
  @type clouderametrics
  tag   tagname                          (default: cloudera.metrics)
  user  username                         (default: user)
  pass  password                         (default: password)
  host  http://cloudera-host.com         (default: http://localhost)
  port  7180                             (default: 7180)
  api_endpoint timeseries
  api_version v19                        (default: v19)
  query select+*+where+roletype=DATANODE
</source>
```

## Copyright

* Copyright(c) 2018- Wesley Yao & Zach Miller
* License
  * MIT
