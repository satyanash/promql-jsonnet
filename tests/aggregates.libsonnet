local promql = import "../promql.libsonnet";

[
  ["it supports aggregation functions like `sum`",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).sum().build(),
    'sum(foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `sum` with a `by` clause",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).sum(by=["host", "version"]).build(),
    'sum by (host,version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `sum` with a `without` clause",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).sum(without=["version"]).build(),
    'sum without (version) (foobar_whatever{environment="staging"})'],
]
