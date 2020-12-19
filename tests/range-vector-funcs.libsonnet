local promql = import "../promql.libsonnet";

[
  ["it supports range vector function `delta`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).delta(["5m", "5m"]).build(),
    'delta(prometheus_http_requests_total{code="200"}[5m:5m])'],
]
