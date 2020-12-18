local promql = import "../promql.libsonnet";

local runTest(t) = {
  result:: t[2](t[1]),
  success: if self.result then self.result else std.trace("FAILED: %s" % t[0], self.result),
};

local testCases = [
  ["it returns a string",
    promql.new("foobar_whatever").build(),
    function(q) std.isString(q)],

  ["it has a metric name",
    promql.new("foobar_whatever").build(),
    function(q) q == "foobar_whatever"],

  ["it supports labels",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).build(),
    function(q) q == 'foobar_whatever{environment="staging"}'],

  ["it supports appending labels",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).addLabels({success:"true"}).build(),
    function(q) q == 'foobar_whatever{environment="staging",success="true"}'],

  ["it supports range intervals",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).withRange("5m").build(),
    function(q) q == 'foobar_whatever{environment="staging"}[5m]'],

  ["it supports range intervals with a resolution",
    promql.new("foobar_whatever").addLabels({environment:"staging"}).withRange("5m", "5m").build(),
    function(q) q == 'foobar_whatever{environment="staging"}[5m:5m]'],
];

local testResults = std.map(runTest, testCases);
local failures = std.filter(function(result) ! result.success, testResults);
local failureCount = std.length(failures);

if failureCount > 0 then "There are %s test failures." % failureCount else "OK"
