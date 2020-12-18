local range(interval, resolution="") = {
  interval: interval,
  resolution: resolution,
  fmt():: if resolution == "" then '[%s]' % interval else '[%s:%s]' % [interval, resolution],
};

{
  new(metricName):: {
    labels:: {},
    addLabels(labels):: self {
      labels+: labels
    },
    labelString():: std.join(',', [std.format('%s="%s"', [k, self.labels[k]]) for k in std.objectFields(self.labels)]),
    labelExpr():: if self.labels == {} then "" else std.format("{%s}", self.labelString()),


    functionTemplates:: [],
    withFuncTemplate(funcTemplate):: self {
      functionTemplates+: [funcTemplate],
    },

    aggr_clause(byLabels, withoutLabels)::
      if byLabels != [] then std.format(" by (%s) ", std.join(",", byLabels))
        else if withoutLabels != [] then std.format(" without (%s) ", std.join(",", withoutLabels))
          else "",
    sum(by=[], without=[]):: self.withFuncTemplate("sum" + self.aggr_clause(by, without) + "(%s)"),
    delta(interval, resolution):: self.withFuncTemplate("delta(%s" + range(interval, resolution).fmt() + ")"),

    runTemplate(query, funcTemplate):: std.format(funcTemplate, query),
    applyFunctions(query):: std.foldl(self.runTemplate, self.functionTemplates, query),

    baseQuery():: "%s%s" % [metricName, self.labelExpr()],
    build():: self.applyFunctions(self.baseQuery()),

    // Instant Vector Functions
    abs():: self.withFuncTemplate("abs(%s)"),
  }
}
