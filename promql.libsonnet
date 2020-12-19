local range(rangeSelector) = {
  interval: rangeSelector[0],
  resolution: rangeSelector[1],
  fmt():: '[%s:%s]' % [self.interval, self.resolution],
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
    exp():: self.withFuncTemplate("exp(%s)"),
    floor():: self.withFuncTemplate("floor(%s)"),
    histogram_quantile(q):: self.withFuncTemplate("histogram_quantile(" + q + ", %s)"),
    ln():: self.withFuncTemplate("ln(%s)"),
    log10():: self.withFuncTemplate("log10(%s)"),
    log2():: self.withFuncTemplate("log2(%s)"),
    round(to_nearest=1):: self.withFuncTemplate("round(%s, " + to_nearest + ")"),
    scalar():: self.withFuncTemplate("scalar(%s)"),
    sort():: self.withFuncTemplate("sort(%s)"),
    sort_desc():: self.withFuncTemplate("sort_desc(%s)"),
    sqrt():: self.withFuncTemplate("sqrt(%s)"),

    // Range Vector Functions
    changes(rangeSelector):: self.withFuncTemplate("changes(%s" + range(rangeSelector).fmt() + ")"),
    absent_over_time(rangeSelector):: self.withFuncTemplate("absent_over_time(%s" + range(rangeSelector).fmt() + ")"),
    delta(rangeSelector):: self.withFuncTemplate("delta(%s" + range(rangeSelector).fmt() + ")"),
    deriv(rangeSelector):: self.withFuncTemplate("deriv(%s" + range(rangeSelector).fmt() + ")"),
    holt_winters(rangeSelector, sf, tf):: self.withFuncTemplate("holt_winters(%s" + range(rangeSelector).fmt() + ", " + sf + ", " + tf + ")"),
    idelta(rangeSelector):: self.withFuncTemplate("idelta(%s" + range(rangeSelector).fmt() + ")"),
    increase(rangeSelector):: self.withFuncTemplate("increase(%s" + range(rangeSelector).fmt() + ")"),
    irate(rangeSelector):: self.withFuncTemplate("irate(%s" + range(rangeSelector).fmt() + ")"),
    rate(rangeSelector):: self.withFuncTemplate("rate(%s" + range(rangeSelector).fmt() + ")"),
    resets(rangeSelector):: self.withFuncTemplate("resets(%s" + range(rangeSelector).fmt() + ")"),

    avg_over_time(rangeSelector):: self.withFuncTemplate("avg_over_time(%s" + range(rangeSelector).fmt() + ")"),
    min_over_time(rangeSelector):: self.withFuncTemplate("min_over_time(%s" + range(rangeSelector).fmt() + ")"),
    max_over_time(rangeSelector):: self.withFuncTemplate("max_over_time(%s" + range(rangeSelector).fmt() + ")"),
    sum_over_time(rangeSelector):: self.withFuncTemplate("sum_over_time(%s" + range(rangeSelector).fmt() + ")"),
    count_over_time(rangeSelector):: self.withFuncTemplate("count_over_time(%s" + range(rangeSelector).fmt() + ")"),
    quantile_over_time(q, rangeSelector):: self.withFuncTemplate("quantile_over_time(" + q + ", %s" + range(rangeSelector).fmt() + ")"),
    stddev_over_time(rangeSelector):: self.withFuncTemplate("stddev_over_time(%s" + range(rangeSelector).fmt() + ")"),
    stdvar_over_time(rangeSelector):: self.withFuncTemplate("stdvar_over_time(%s" + range(rangeSelector).fmt() + ")"),
  }
}
