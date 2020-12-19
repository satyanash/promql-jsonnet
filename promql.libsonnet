local range(interval, resolution="") = {
  interval: interval,
  resolution: resolution,
  fmt():: if resolution == "" then '[%s]' % interval else '[%s:%s]' % [interval, resolution],
};

{
  new(metricName):: {
    labels:: {},
    withLabels(labels):: self {
      labels+: labels
    },
    labelString():: std.join(',', [std.format('%s="%s"', [k, self.labels[k]]) for k in std.objectFields(self.labels)]),
    labelExpr():: if self.labels == {} then "" else std.format("{%s}", self.labelString()),


    functionTemplates:: [],
    withFuncTemplate(funcTemplate):: self {
      functionTemplates+: [funcTemplate],
    },
    delta(interval, resolution):: self.withFuncTemplate("delta(%s" + range(interval, resolution).fmt() + ")"),

    runTemplate(query, funcTemplate):: std.format(funcTemplate, query),
    applyFunctions(query):: std.foldl(self.runTemplate, self.functionTemplates, query),

    baseQuery():: "%s%s" % [metricName, self.labelExpr()],
    build():: self.applyFunctions(self.baseQuery()),

    // Aggregate Functions
    aggr_clause(byLabels, withoutLabels)::
      if byLabels != [] then std.format(" by (%s) ", std.join(",", byLabels))
        else if withoutLabels != [] then std.format(" without (%s) ", std.join(",", withoutLabels))
          else "",

    sum(by=[], without=[]):: self.withFuncTemplate("sum" + self.aggr_clause(by, without) + "(%s)"),
    min(by=[], without=[]):: self.withFuncTemplate("min" + self.aggr_clause(by, without) + "(%s)"),
    max(by=[], without=[]):: self.withFuncTemplate("max" + self.aggr_clause(by, without) + "(%s)"),
    avg(by=[], without=[]):: self.withFuncTemplate("avg" + self.aggr_clause(by, without) + "(%s)"),
    group(by=[], without=[]):: self.withFuncTemplate("group" + self.aggr_clause(by, without) + "(%s)"),
    stddev(by=[], without=[]):: self.withFuncTemplate("stddev" + self.aggr_clause(by, without) + "(%s)"),
    stdvar(by=[], without=[]):: self.withFuncTemplate("stdvar" + self.aggr_clause(by, without) + "(%s)"),
    count(by=[], without=[]):: self.withFuncTemplate("count" + self.aggr_clause(by, without) + "(%s)"),
    count_values(labelName, by=[], without=[]):: self.withFuncTemplate("count_values" + self.aggr_clause(by, without) + "(\"" + labelName + "\", %s)"),
    bottomk(k, by=[], without=[]):: self.withFuncTemplate("bottomk" + self.aggr_clause(by, without) + "(" + k + ", %s)"),
    topk(k, by=[], without=[]):: self.withFuncTemplate("topk" + self.aggr_clause(by, without) + "(" + k + ", %s)"),
    quantile(q, by=[], without=[]):: self.withFuncTemplate("quantile" + self.aggr_clause(by, without) + "(" + q + ", %s)"),

    // Instant Vector Functions
    abs():: self.withFuncTemplate("abs(%s)"),
    absent():: self.withFuncTemplate("absent(%s)"),
    ceil():: self.withFuncTemplate("ceil(%s)"),
    clamp_max(max):: self.withFuncTemplate("clamp_max(%s, " + max + ")"),
    clamp_min(min):: self.withFuncTemplate("clamp_min(%s, " + min + ")"),
    ln():: self.withFuncTemplate("ln(%s)"),
    log10():: self.withFuncTemplate("log10(%s)"),
    log2():: self.withFuncTemplate("log2(%s)"),
    scalar():: self.withFuncTemplate("scalar(%s)"),
    sort():: self.withFuncTemplate("sort(%s)"),
    sort_desc():: self.withFuncTemplate("sort_desc(%s)"),
    sqrt():: self.withFuncTemplate("sqrt(%s)"),
  }
}
