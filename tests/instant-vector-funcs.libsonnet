local promql = import "../promql.libsonnet";

[
  ["it supports instant vector function `abs`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).abs().build(),
    'abs(prometheus_http_requests_total{code="200"})'],

  ["it supports instant vector function `absent`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).absent().build(),
    'absent(prometheus_http_requests_total{code="200"})'],
]
