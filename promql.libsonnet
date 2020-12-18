{
  new(metricName):: {
    labels:: {},
    addLabels(labels):: self {
      labels+: labels
    },
    labelString():: std.join(',', [std.format('%s="%s"', [k, self.labels[k]]) for k in std.objectFields(self.labels)]),
    labelExpr():: if self.labels == {} then "" else std.format("{%s}", self.labelString()),

    range:: {
      interval:: "",
      resolution:: "",
    },
    withRange(interval, resolution=""):: self {
      range+: {
        interval: interval,
        resolution: resolution,
      },
    },
    rangeStr()::
      if self.range.interval == "" then ""
        else if self.range.resolution == "" then '[%s]' % self.range.interval
          else '[%s:%s]' % [self.range.interval, self.range.resolution],

    functions:: [],
    withFunc(func):: self {
      functions+: [func],
    },
    sum():: self.withFunc("sum"),
    applyFunction(query, func):: std.format('%s(%s)', [func, query]),
    applyFunctions(query):: std.foldl(self.applyFunction, self.functions, query),

    baseQuery():: "%s%s%s" % [metricName, self.labelExpr(), self.rangeStr()],
    build():: self.applyFunctions(self.baseQuery()),
  }
}
