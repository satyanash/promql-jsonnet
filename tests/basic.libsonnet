local promql = import "../promql.libsonnet";

[
  ["it has a metric name",
    promql.new("prometheus_http_requests_total").build(),
    "prometheus_http_requests_total"],

  ["it supports labels",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).build(),
    'prometheus_http_requests_total{code="200"}'],

  ["it supports appending labels",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).withLabels({success:"true"}).build(),
    'prometheus_http_requests_total{code="200",success="true"}'],
]
