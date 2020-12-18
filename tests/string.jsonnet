local promql = import "../promql.libsonnet";

local runTest(t) = {
  success: t[2](t[1]),
  test: if self.success then t[0] else std.trace("FAILED: %s" % t[0], t[0]),
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
];

{
    testResults: std.map(runTest, testCases),
}
