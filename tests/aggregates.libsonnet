local promql = import "../promql.libsonnet";

[
  ["it supports aggregation functions like `sum`",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).sum().build(),
    'sum(foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `sum` with a `by` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).sum(by=["host", "version"]).build(),
    'sum by (host,version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `sum` with a `without` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).sum(without=["version"]).build(),
    'sum without (version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `min`",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).min().build(),
    'min(foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `min` with a `by` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).min(by=["host", "version"]).build(),
    'min by (host,version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `min` with a `without` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).min(without=["version"]).build(),
    'min without (version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `max`",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).max().build(),
    'max(foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `max` with a `by` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).max(by=["host", "version"]).build(),
    'max by (host,version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `max` with a `without` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).max(without=["version"]).build(),
    'max without (version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `avg`",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).avg().build(),
    'avg(foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `avg` with a `by` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).avg(by=["host", "version"]).build(),
    'avg by (host,version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `avg` with a `without` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).avg(without=["version"]).build(),
    'avg without (version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `group`",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).group().build(),
    'group(foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `group` with a `by` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).group(by=["host", "version"]).build(),
    'group by (host,version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `group` with a `without` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).group(without=["version"]).build(),
    'group without (version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `stddev`",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).stddev().build(),
    'stddev(foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `stddev` with a `by` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).stddev(by=["host", "version"]).build(),
    'stddev by (host,version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `stddev` with a `without` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).stddev(without=["version"]).build(),
    'stddev without (version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `stdvar`",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).stdvar().build(),
    'stdvar(foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `stdvar` with a `by` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).stdvar(by=["host", "version"]).build(),
    'stdvar by (host,version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `stdvar` with a `without` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).stdvar(without=["version"]).build(),
    'stdvar without (version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `count`",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).count().build(),
    'count(foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `count` with a `by` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).count(by=["host", "version"]).build(),
    'count by (host,version) (foobar_whatever{environment="staging"})'],

  ["it supports aggregation functions like `count` with a `without` clause",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).count(without=["version"]).build(),
    'count without (version) (foobar_whatever{environment="staging"})'],
]
