local promql = import "promql.libsonnet";

local basicTests = import "tests/basic.libsonnet";
local aggregateTests = import "tests/aggregates.libsonnet";

basicTests + aggregateTests + [
  ["it supports instant vector functions like `abs`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).abs().build(),
    'abs(prometheus_http_requests_total{code="200"})'],

  ["it supports range vector functions like `delta`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).delta("5m", "5m").build(),
    'delta(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports function composition in the given order",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).abs().delta("5m", "5m").build(),
    'delta(abs(prometheus_http_requests_total{code="200"})[5m:5m])'],
]
