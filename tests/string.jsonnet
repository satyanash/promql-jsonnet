local promql = import "../promql.libsonnet";

local runTest(t) = {
  result:: t[2] == t[1],
  success: if self.result then self.result else std.trace("FAILED: %s - EXPECTED: %s - ACTUAL: %s" % [t[0], t[2], t[1]], self.result),
};

local testCases = [
  ["it has a metric name",
    promql.new("foobar_whatever").build(),
    "foobar_whatever"],

  ["it supports labels",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).build(),
    'foobar_whatever{environment="staging"}'],

  ["it supports appending labels",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).addLabels({success:"true"}).build(),
    'foobar_whatever{environment="staging",success="true"}'],

  ["it supports range intervals",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).withRange("5m").build(),
    'foobar_whatever{environment="staging"}[5m]'],

  ["it supports range intervals with a resolution",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).withRange("5m", "5m").build(),
    'foobar_whatever{environment="staging"}[5m:5m]'],

  ["it supports the sum function",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).sum().build(),
    'sum(foobar_whatever{environment="staging"})'],
];

local testResults = std.map(runTest, testCases);
local failures = std.filter(function(result) ! result.success, testResults);
local failureCount = std.length(failures);

if failureCount > 0 then "There are %s test failures." % failureCount else "OK"
