local promql = import "../promql.libsonnet";

{
  success: if std.isString(promql.new().build()) then true else error "output is not a string"
}
