# `promql-jsonnet` ![promql-jsonnet](https://circleci.com/gh/satyanash/promql-jsonnet.svg?style=shield)

A [Jsonnet](https://jsonnet.org) based DSL for writing [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/) queries.
This is useful when coupled with the [prometheus target](https://grafana.github.io/grafonnet-lib/api-docs/#prometheustarget) in [`grafonnet`](https://github.com/grafana/grafonnet-lib/).

## Usage

Usage is very natural, if you know what you're looking to construct.
For example, let's construct a PromQL for a counter:

``` promql
delta(sum(prometheus_http_requests_total{code="200",handler="/api/v1/query"})[5m:5m])
```

The corresponding usage in jsonnet would look something like this:

``` jsonnet
local promql = import "promql.libsonnet";

promql.new("prometheus_http_requests_total")
    .withLabels({
        code: "200",
        handler: "/api/v1/query",
    })
    .sum()
    .delta("5m", "5m")
    .build()
```

## PromQL Support

Below tables list out the support for the various PromQL operators and functions.

### Aggregation operators

These support additional clauses like `by` and `without`. For eg:

``` promql
promql.new("prometheus_http_requests_total").sum(by=["handler", "instance"])

// Output: sum by (handler,instance) (prometheus_http_requests_total)
```

| Function                               | Support            |
|----------------------------------------|--------------------|
| `sum(instant-vector)`                  | :heavy_check_mark: |
| `min(instant-vector)`                  | :heavy_check_mark: |
| `max(instant-vector)`                  | :heavy_check_mark: |
| `avg(instant-vector)`                  | :heavy_check_mark: |
| `group(instant-vector)`                | :heavy_check_mark: |
| `stddev(instant-vector)`               | :heavy_check_mark: |
| `stdvar(instant-vector)`               | :heavy_check_mark: |
| `count(instant-vector)`                | :heavy_check_mark: |
| `count_values(string, instant-vector)` | :heavy_check_mark: |
| `bottomk(scalar, instant-vector)`      | :heavy_check_mark: |
| `topk(scalar, instant-vector)`         | :heavy_check_mark: |
| `quantile(scalar, instant-vector)`     | :heavy_check_mark: |

### Instant Vector Functions

| Function                                                        | Support            |
|-----------------------------------------------------------------|--------------------|
| `abs(instant-vector)`                                           | :heavy_check_mark: |
| `absent(instant-vector)`                                        | :heavy_check_mark: |
| `ceil(instant-vector)`                                          | :construction:     |
| `clamp_max(instant-vector, scalar)`                             | :construction:     |
| `clamp_min(instant-vector, scalar)`                             | :construction:     |
| `exp(instant-vector)`                                           | :construction:     |
| `floor(instant-vector)`                                         | :construction:     |
| `histogram_quantile(scalar, instant-vector)`                    | :construction:     |
| `label_join(instant-vector, string, string, string...)`         | :construction:     |
| `label_replace(instant-vector, string, string, string, string)` | :construction:     |
| `ln(instant-vector)`                                            | :construction:     |
| `log10(instant-vector)`                                         | :construction:     |
| `log2(instant-vector)`                                          | :construction:     |
| `round(instant-vector, scalar)`                                 | :construction:     |
| `scalar(instant-vector)`                                        | :construction:     |
| `sort(instant-vector)`                                          | :construction:     |
| `sort_desc(instant-vector)`                                     | :construction:     |
| `sqrt(instant-vector)`                                          | :construction:     |

### Range Vector Functions

| Function                                     | Support            |
|----------------------------------------------|--------------------|
| `changes(range-vector)`                      | :construction:     |
| `absent_over_time(range-vector)`             | :construction:     |
| `delta(range-vector)`                        | :heavy_check_mark: |
| `deriv(range-vector)`                        | :construction:     |
| `holt_winters(range-vector, scalar, scalar)` | :construction:     |
| `idelta(range-vector)`                       | :construction:     |
| `increase(range-vector)`                     | :construction:     |
| `irate(range-vector)`                        | :construction:     |
| `predict_linear(range-vector, scalar)`       | :construction:     |
| `rate(range-vector)`                         | :construction:     |
| `resets(range-vector)`                       | :construction:     |
|                                              |                    |
| `avg_over_time(range-vector)`                | :construction:     |
| `min_over_time(range-vector)`                | :construction:     |
| `max_over_time(range-vector)`                | :construction:     |
| `sum_over_time(range-vector)`                | :construction:     |
| `count_over_time(range-vector)`              | :construction:     |
| `quantile_over_time(scalar, range-vector)`   | :construction:     |
| `stddev_over_time(range-vector)`             | :construction:     |
| `stdvar_over_time(range-vector)`             | :construction:     |


## Running the tests

* Unit Tests: `jsonnet unit-tests.jsonnet`
* Integration Tests
  1. Start a prometheus listening at `http://localhost:9090` with
  ``` shell
  docker run -p 127.0.0.1:9090:9090 --rm --name "promql-jsonnet-prometheus" -it prom/prometheus
  ```
  2. Run `./integration_tests.sh`
