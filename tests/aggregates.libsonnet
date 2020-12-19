local promql = import "../promql.libsonnet";

[
  ["it supports aggregation functions like `sum`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).sum().build(),
    'sum(prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `sum` with a `by` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).sum(by=["host", "version"]).build(),
    'sum by (host,version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `sum` with a `without` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).sum(without=["version"]).build(),
    'sum without (version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `min`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).min().build(),
    'min(prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `min` with a `by` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).min(by=["host", "version"]).build(),
    'min by (host,version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `min` with a `without` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).min(without=["version"]).build(),
    'min without (version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `max`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).max().build(),
    'max(prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `max` with a `by` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).max(by=["host", "version"]).build(),
    'max by (host,version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `max` with a `without` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).max(without=["version"]).build(),
    'max without (version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `avg`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).avg().build(),
    'avg(prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `avg` with a `by` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).avg(by=["host", "version"]).build(),
    'avg by (host,version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `avg` with a `without` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).avg(without=["version"]).build(),
    'avg without (version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `group`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).group().build(),
    'group(prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `group` with a `by` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).group(by=["host", "version"]).build(),
    'group by (host,version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `group` with a `without` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).group(without=["version"]).build(),
    'group without (version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `stddev`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).stddev().build(),
    'stddev(prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `stddev` with a `by` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).stddev(by=["host", "version"]).build(),
    'stddev by (host,version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `stddev` with a `without` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).stddev(without=["version"]).build(),
    'stddev without (version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `stdvar`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).stdvar().build(),
    'stdvar(prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `stdvar` with a `by` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).stdvar(by=["host", "version"]).build(),
    'stdvar by (host,version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `stdvar` with a `without` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).stdvar(without=["version"]).build(),
    'stdvar without (version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `count`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).count().build(),
    'count(prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `count` with a `by` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).count(by=["host", "version"]).build(),
    'count by (host,version) (prometheus_http_requests_total{code="200"})'],

  ["it supports aggregation functions like `count` with a `without` clause",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).count(without=["version"]).build(),
    'count without (version) (prometheus_http_requests_total{code="200"})'],
]
