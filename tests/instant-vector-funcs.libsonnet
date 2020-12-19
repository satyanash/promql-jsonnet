local promql = import "../promql.libsonnet";

[
  ["it supports instant vector function `abs`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).abs().build(),
    'abs(prometheus_http_requests_total{code="200"})'],

  ["it supports instant vector function `absent`",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).absent().build(),
    'absent(prometheus_http_requests_total{code="200"})'],

  ["it supports instant vector function `ceil`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).ceil().build(),
    'ceil(prometheus_engine_query_duration_seconds{slice="prepare_time"})'],

  ["it supports instant vector function `clamp_max`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).clamp_max(1).build(),
    'clamp_max(prometheus_engine_query_duration_seconds{slice="prepare_time"}, 1)'],

  ["it supports instant vector function `clamp_min`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).clamp_min(1).build(),
    'clamp_min(prometheus_engine_query_duration_seconds{slice="prepare_time"}, 1)'],

  ["it supports instant vector function `exp`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).exp().build(),
    'exp(prometheus_engine_query_duration_seconds{slice="prepare_time"})'],

  ["it supports instant vector function `floor`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).floor().build(),
    'floor(prometheus_engine_query_duration_seconds{slice="prepare_time"})'],

  ["it supports instant vector function `ln`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).ln().build(),
    'ln(prometheus_engine_query_duration_seconds{slice="prepare_time"})'],

  ["it supports instant vector function `log10`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).log10().build(),
    'log10(prometheus_engine_query_duration_seconds{slice="prepare_time"})'],

  ["it supports instant vector function `log2`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).log2().build(),
    'log2(prometheus_engine_query_duration_seconds{slice="prepare_time"})'],

  ["it supports instant vector function `scalar`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time", job:"prometheus"}).scalar().build(),
    'scalar(prometheus_engine_query_duration_seconds{job="prometheus",slice="prepare_time"})'],

  ["it supports instant vector function `sort`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).sort().build(),
    'sort(prometheus_engine_query_duration_seconds{slice="prepare_time"})'],

  ["it supports instant vector function `sort_desc`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).sort_desc().build(),
    'sort_desc(prometheus_engine_query_duration_seconds{slice="prepare_time"})'],

  ["it supports instant vector function `sqrt`",
    promql.new("prometheus_engine_query_duration_seconds").withLabels({slice:"prepare_time"}).sqrt().build(),
    'sqrt(prometheus_engine_query_duration_seconds{slice="prepare_time"})'],
]
