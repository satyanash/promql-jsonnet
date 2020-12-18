local promql = import "../promql.libsonnet";

local runTest(t) = {
  result:: t[2] == t[1],
  success: if self.result then self.result else std.trace("FAILED: %s \n - EXPECTED: %s \n - ACTUAL:   %s" % [t[0], t[2], t[1]], self.result),
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

  ["it supports instant vector functions like `sum`",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).sum().build(),
    'sum(foobar_whatever{environment="staging"})'],

  ["it supports range vector functions like `delta`",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).delta("5m", "5m").build(),
    'delta(foobar_whatever{environment="staging"}[5m:5m])'],
];

local testResults = std.map(runTest, testCases);
local failures = std.filter(function(result) ! result.success, testResults);
local failureCount = std.length(failures);

if failureCount > 0 then "There are %s test failures." % failureCount else "OK"
