local promql = import "promql.libsonnet";

local basicTests = import "tests/basic.libsonnet";
local aggregateTests = import "tests/aggregates.libsonnet";

local runTest(t) = {
  result:: t[2] == t[1],
  success: if self.result then self.result else std.trace("FAILED: %s \n - EXPECTED: %s \n - ACTUAL:   %s" % [t[0], t[2], t[1]], self.result),
};

local testCases = basicTests + aggregateTests + [
  ["it supports instant vector functions like `abs`",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).abs().build(),
    'abs(foobar_whatever{environment="staging"})'],

  ["it supports range vector functions like `delta`",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).delta("5m", "5m").build(),
    'delta(foobar_whatever{environment="staging"}[5m:5m])'],

  ["it supports function composition in the given order",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).abs().delta("5m", "5m").build(),
    'delta(abs(foobar_whatever{environment="staging"})[5m:5m])'],
];

local testResults = std.map(runTest, testCases);

local failures = std.filter(function(result) ! result.success, testResults);
local failureCount = std.length(failures);

local successes = std.filter(function(result) result.success, testResults);
local successCount = std.length(successes);

if failureCount > 0 then "There are %s test failures." % failureCount else "OK - %s Tests" % successCount
