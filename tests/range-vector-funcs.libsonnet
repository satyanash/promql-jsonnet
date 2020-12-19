local promql = import "../promql.libsonnet";

[
  ["it supports range vector function `changes`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).changes(["5m", "5m"]).build(),
    'changes(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `absent_over_time`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).absent_over_time(["5m", "5m"]).build(),
    'absent_over_time(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `delta`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).delta(["5m", "5m"]).build(),
    'delta(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `deriv`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).deriv(["5m", "5m"]).build(),
    'deriv(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `idelta`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).idelta(["5m", "5m"]).build(),
    'idelta(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `increase`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).increase(["5m", "5m"]).build(),
    'increase(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `irate`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).irate(["5m", "5m"]).build(),
    'irate(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `rate`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).rate(["5m", "5m"]).build(),
    'rate(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `resets`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).resets(["5m", "5m"]).build(),
    'resets(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `avg_over_time`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).avg_over_time(["5m", "5m"]).build(),
    'avg_over_time(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `min_over_time`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).min_over_time(["5m", "5m"]).build(),
    'min_over_time(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `max_over_time`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).max_over_time(["5m", "5m"]).build(),
    'max_over_time(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `sum_over_time`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).sum_over_time(["5m", "5m"]).build(),
    'sum_over_time(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `count_over_time`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).count_over_time(["5m", "5m"]).build(),
    'count_over_time(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `stddev_over_time`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).stddev_over_time(["5m", "5m"]).build(),
    'stddev_over_time(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports range vector function `stdvar_over_time`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).stdvar_over_time(["5m", "5m"]).build(),
    'stdvar_over_time(prometheus_http_requests_total{code="200"}[5m:5m])'],
]
