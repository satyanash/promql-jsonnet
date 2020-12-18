local promql = import "../promql.libsonnet";

[
  ["it has a metric name",
    promql.new("foobar_whatever").build(),
    "foobar_whatever"],

  ["it supports labels",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).build(),
    'foobar_whatever{environment="staging"}'],

  ["it supports appending labels",
    promql.new("foobar_whatever").withLabels({environment:"staging"}).withLabels({success:"true"}).build(),
    'foobar_whatever{environment="staging",success="true"}'],
]
