local promql = import "../promql.libsonnet";

{
  isString: if std.isString(promql.new("foobar_whatever").build()) then true else error "output is not a string",
  hasMetricName: if promql.new("foobar_whatever").build() == "foobar_whatever" then true else error "output does not match metric name",
}
