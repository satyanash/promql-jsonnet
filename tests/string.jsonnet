local promql = import "../promql.libsonnet";

{
  isString: if std.isString(promql.new("foobar_whatever").build())
  then true else error "output is not a string",

  hasMetricName: if promql.new("foobar_whatever").build() == "foobar_whatever"
  then true else error "output does not match metric name",

  itSupportsLabels: if promql.new("foobar_whatever").addLabels({environment:"staging"}).build()
  == 'foobar_whatever{environment="staging"}'
  then true else error "output does not have labels added",

  itSupportsAddingLabels: if promql.new("foobar_whatever").addLabels({environment:"staging"}).addLabels({success:"true"}).build()
  == 'foobar_whatever{environment="staging",success="true"}' then true
  else error "output does not have labels added",
}
