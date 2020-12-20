local promql = import "../promql.libsonnet";

[
  ["it supports specifying multiple labels as an object",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).build(),
    'prometheus_http_requests_total{code="200"}'],

  ["it supports merging multiple objects into a single set of labels",
    promql.new("prometheus_http_requests_total").withLabels({code:"200"}).withLabels({success:"true"}).build(),
    'prometheus_http_requests_total{code="200",success="true"}'],

  ["it supports the `=` label matcher",
    promql.new("prometheus_http_requests_total")
          .withLabels({code:"200"})
          .withLabel({key:"success", op:"=", value:"true"})
          .build(),
    'prometheus_http_requests_total{code="200",success="true"}'],

  ["it supports the `=~` label matcher",
    promql.new("prometheus_http_requests_total")
          .withLabels({code:"200"})
          .withLabel({key:"handler", op:"=~", value:"/api/v1/"})
          .build(),
    'prometheus_http_requests_total{code="200",handler=~"/api/v1/"}'],

  ["it supports the `!=` label matcher",
    promql.new("prometheus_http_requests_total")
          .withLabels({code:"200"})
          .withLabel({key:"success", op:"!=", value:"true"})
          .build(),
    'prometheus_http_requests_total{code="200",success!="true"}'],

  ["it supports the `!~` label matcher",
    promql.new("prometheus_http_requests_total")
          .withLabels({code:"200"})
          .withLabel({key:"handler", op:"!~", value:"/api/v1"})
          .build(),
    'prometheus_http_requests_total{code="200",handler!~"/api/v1"}'],
]
