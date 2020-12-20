local promql = import "../promql.libsonnet";

[
  ["it has a metric name",
    promql.new("prometheus_http_requests_total").build(),
    "prometheus_http_requests_total"],

  ["it supports function composition in the given order",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).delta(["5m", "5m"]).abs().build(),
    'abs(delta(prometheus_http_requests_total{code="200"}[5m:5m]))']
]
