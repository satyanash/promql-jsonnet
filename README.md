# `promql-jsonnet` ![promql-jsonnet](https://circleci.com/gh/satyanash/promql-jsonnet.svg?style=shield)

A [Jsonnet](https://jsonnet.org) based DSL for writing [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/) queries.
This is useful when creating grafana dashboards using [`grafonnet`](https://github.com/grafana/grafonnet-lib/).
Instead of having to template strings manually, you can now use immutable builders to DRY out your PromQL queries.

This library generates json strings, which can be fed to the `expr` field of the [prometheus target](https://grafana.github.io/grafonnet-lib/api-docs/#prometheustarget) in graffonet.

## Getting Started

Usage is natural, if you know what you're looking to construct.
Here is a quick example to construct a PromQL for a counter:

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
      .delta(["5m","5m"])
      .build()
```

### Basic Usage

1. Import `promql` from the `promql.libsonnet` file.
2. Use `promql.new("...")` to start creating a query.
3. You can specify labels to filter with `.withLabels({...})`.
4. Call functions for any aggregations, transformations that you want to do.
5. Finally don't forget to call `.build()` to get the generated PromQL query as a jsonnet string.
6. You can pass this to the `expr` field for the `prometheus` target from grafonnet like this:
   ``` jsonnet
   local promql = import "promql.libsonnet";
   local grafana = import "grafonnet.libsonnet";

   local http_sucess_query = promql.new("prometheus_http_requests_total")
                                   .withLabels({code:"200"})
                                   .sum()
                                   .delta(["$__interval", "$__interval"])
                                   .build();

   grafana.prometheus.target(
       expr= http_sucess_query
       //...
   )

   ```

### Aggregation operators

* Aggregation operators like `sum`, `avg` etc. take instant vectors and return another instant vector.
* These support following optional clauses that take a list of labels:
  * `by` clause - `.topk(5, by=["host"])`
  * `without` clause - `.avg(without=["handler"])`

* Sample usage:
  ``` jsonnet
  promql.new("prometheus_http_requests_total")
        .withLabels({code:"200"})
        .sum(by=["handler", "instance"])
        .build()
  // output: sum by (handler,instance) (prometheus_http_requests_total{code="200"})
  ```

### Range Vector Functions

* A PromQL Range Selector is represented in jsonnet by a 2-tuple of duration strings: `["1m","1m"]`.
* The first one represents the actual range, while the second is the resolution.
* Since applying a range selector by itself is not of much use, this library couples it to all functions that expect a range-vector.
* Thus to construct `delta(prometheus_http_requests_total{status_code="200"}[1m:1m])`, the code would look like:
  ``` jsonnet
  promql.new("prometheus_http_requests_total")
        .withLabels({status_code:"200"})
        .delta(["1m","1m"])
        .build()
  ```
* When using Grafana, you want to let it fill appropriate durations for the range selectors using the `$__interval` variable.
  To support this, we don't perform any validation for the duration fields, thus code like this is allowed:
  ``` jsonnet
  promql.new("prometheus_http_requests_total")
        .withLabels({status_code:"200"})
        .delta(["$__interval","$__interval"])
        .build()
  // output: delta(prometheus_http_requests_total{status_code="200"}[$__interval:$__interval])
  ```

## API Reference and PromQL Support

| PromQL Function                                                 | Jsonnet Usage                              | Support            |
|-----------------------------------------------------------------|--------------------------------------------|--------------------|
| *Aggregation Functions*                                         |                                            |                    |
| `sum(instant-vector)`                                           | `.sum()`                                   | :heavy_check_mark: |
| `min(instant-vector)`                                           | `.min()`                                   | :heavy_check_mark: |
| `max(instant-vector)`                                           | `.max()`                                   | :heavy_check_mark: |
| `avg(instant-vector)`                                           | `.avg()`                                   | :heavy_check_mark: |
| `group(instant-vector)`                                         | `.group()`                                 | :heavy_check_mark: |
| `stddev(instant-vector)`                                        | `.stddev()`                                | :heavy_check_mark: |
| `stdvar(instant-vector)`                                        | `.stdvar()`                                | :heavy_check_mark: |
| `count(instant-vector)`                                         | `.count()`                                 | :heavy_check_mark: |
| `count_values(string, instant-vector)`                          | `.count_values("my-label-name")`           | :heavy_check_mark: |
| `bottomk(scalar, instant-vector)`                               | `.bottomk(5)`                              | :heavy_check_mark: |
| `topk(scalar, instant-vector)`                                  | `.topk(5)`                                 | :heavy_check_mark: |
| `quantile(scalar, instant-vector)`                              | `.quantile("0.99")`                        | :heavy_check_mark: |
|                                                                 |                                            |                    |
| *Instant Vector Functions*                                      |                                            |                    |
| `abs(instant-vector)`                                           | `.abs()`                                   | :heavy_check_mark: |
| `absent(instant-vector)`                                        | `.absent()`                                | :heavy_check_mark: |
| `ceil(instant-vector)`                                          | `.ceil()`                                  | :heavy_check_mark: |
| `clamp_max(instant-vector, scalar)`                             | `.clamp_max(5)`                            | :heavy_check_mark: |
| `clamp_min(instant-vector, scalar)`                             | `.clamp_min(5)`                            | :heavy_check_mark: |
| `exp(instant-vector)`                                           | `.exp()`                                   | :heavy_check_mark: |
| `floor(instant-vector)`                                         | `.floor()`                                 | :heavy_check_mark: |
| `histogram_quantile(scalar, instant-vector)`                    | `.histogram_quantile("0.90")`              | :heavy_check_mark: |
| `label_join(instant-vector, string, string, string...)`         |                                            | :construction:     |
| `label_replace(instant-vector, string, string, string, string)` |                                            | :construction:     |
| `ln(instant-vector)`                                            | `.ln()`                                    | :heavy_check_mark: |
| `log10(instant-vector)`                                         | `.log10()`                                 | :heavy_check_mark: |
| `log2(instant-vector)`                                          | `.log2()`                                  | :heavy_check_mark: |
| `round(instant-vector, scalar)`                                 | `.round(2)`                                | :heavy_check_mark: |
| `scalar(instant-vector)`                                        | `.scalar()`                                | :heavy_check_mark: |
| `sort(instant-vector)`                                          | `.sort()`                                  | :heavy_check_mark: |
| `sort_desc(instant-vector)`                                     | `.sort_desc()`                             | :heavy_check_mark: |
| `sqrt(instant-vector)`                                          | `.sqrt()`                                  | :heavy_check_mark: |
|                                                                 |                                            |                    |
| `day_of_month(instant-vector)`                                  |                                            | :construction:     |
| `day_of_week(instant-vector)`                                   |                                            | :construction:     |
| `days_in_month(instant-vector)`                                 |                                            | :construction:     |
| `hour(instant-vector)`                                          |                                            | :construction:     |
| `minute(instant-vector)`                                        |                                            | :construction:     |
| `month(instant-vector)`                                         |                                            | :construction:     |
| `year(instant-vector)`                                          |                                            | :construction:     |
| `timestamp(instant-vector)`                                     |                                            | :construction:     |
|                                                                 |                                            |                    |
| *Range Vector Functions*                                        |                                            |                    |
| `changes(range-vector)`                                         | `.changes(["1m","1m"])`                    | :heavy_check_mark: |
| `absent_over_time(range-vector)`                                | `.absent_over_time(["1m","1m"])`           | :heavy_check_mark: |
| `delta(range-vector)`                                           | `.delta(["1m","1m"])`                      | :heavy_check_mark: |
| `deriv(range-vector)`                                           | `.deriv(["1m","1m"])`                      | :heavy_check_mark: |
| `holt_winters(range-vector, scalar, scalar)`                    | `.holt_winters(["1m","1m"], "0.5", "0.5")` | :heavy_check_mark: |
| `idelta(range-vector)`                                          | `.idelta(["1m","1m"])`                     | :heavy_check_mark: |
| `increase(range-vector)`                                        | `.increase(["1m","1m"])`                   | :heavy_check_mark: |
| `irate(range-vector)`                                           | `.irate(["1m","1m"])`                      | :heavy_check_mark: |
| `predict_linear(range-vector, scalar)`                          | `.predict_linear(["1m","1m"], 60)`         | :heavy_check_mark: |
| `rate(range-vector)`                                            | `.rate(["1m","1m"])`                       | :heavy_check_mark: |
| `resets(range-vector)`                                          | `.resets(["1m","1m"])`                     | :heavy_check_mark: |
|                                                                 |                                            |                    |
| `avg_over_time(range-vector)`                                   | `.avg_over_time(["1m","1m"])`              | :heavy_check_mark: |
| `min_over_time(range-vector)`                                   | `.min_over_time(["1m","1m"])`              | :heavy_check_mark: |
| `max_over_time(range-vector)`                                   | `.max_over_time(["1m","1m"])`              | :heavy_check_mark: |
| `sum_over_time(range-vector)`                                   | `.sum_over_time(["1m","1m"])`              | :heavy_check_mark: |
| `count_over_time(range-vector)`                                 | `.count_over_time(["1m","1m"])`            | :heavy_check_mark: |
| `quantile_over_time(scalar, range-vector)`                      | `.quantile_over_time("0.90", ["1m","1m"])` | :heavy_check_mark: |
| `stddev_over_time(range-vector)`                                | `.stddev_over_time(["1m","1m"])`           | :heavy_check_mark: |
| `stdvar_over_time(range-vector)`                                | `.stdvar_over_time(["1m","1m"])`           | :heavy_check_mark: |
|                                                                 |                                            |                    |
| *Miscellaneous Functions*                                       |                                            |                    |
| `vector(scalar)`                                                |                                            | :construction:     |
| `time()`                                                        |                                            | :construction:     |

## Running the tests

* Unit Tests: `jsonnet unit-tests.jsonnet`
* Integration Tests
  1. Start a prometheus listening at `http://localhost:9090` with
     ``` shell
     docker run -p 127.0.0.1:9090:9090 --rm --name "promql-jsonnet-prometheus" -it prom/prometheus
     ```
  2. Run `./integration_tests.sh`
