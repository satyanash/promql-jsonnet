local promql = import "promql.libsonnet";

local basicTests = import "tests/basic.libsonnet";
local labelMatchers = import "tests/label-matchers.libsonnet";
local aggregateTests = import "tests/aggregates.libsonnet";
local instantVectorFuncTests = import "tests/instant-vector-funcs.libsonnet";
local rangeVectorFuncTests = import "tests/range-vector-funcs.libsonnet";

basicTests + labelMatchers + aggregateTests + instantVectorFuncTests + rangeVectorFuncTests
