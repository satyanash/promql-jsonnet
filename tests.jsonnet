local promql = import "promql.libsonnet";

local basicTests = import "tests/basic.libsonnet";
local aggregateTests = import "tests/aggregates.libsonnet";
local instantVectorFuncTests = import "tests/instant-vector-funcs.libsonnet";

basicTests + aggregateTests + instantVectorFuncTests + [
  ["it supports range vector function `delta`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).delta("5m", "5m").build(),
    'delta(prometheus_http_requests_total{code="200"}[5m:5m])'],

  ["it supports function composition in the given order",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).abs().delta("5m", "5m").build(),
    'delta(abs(prometheus_http_requests_total{code="200"})[5m:5m])'],
]
