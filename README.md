# `jsonnet-promql`

Build PromQL queries with jsonnet.

## Usage

``` jsonnet
local promql = import "promql.libsonnet";

promql.query()
```

## Running the tests

``` shell
jsonnet tests/string.jsonnet
```
