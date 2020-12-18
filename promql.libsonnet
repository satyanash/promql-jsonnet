{
  new(metricName):: {
    labels:: {},
    addLabels(labels):: self {
      labels+: labels
    },
    labelString():: std.join(',', [std.format('%s="%s"', [k, self.labels[k]]) for k in std.objectFields(self.labels)]),
    labelExpr():: if self.labels == {} then "" else std.format("{%s}", self.labelString()),


    functions:: [],
    withInstantVectorFunc(func):: self {
      functions+: [{
        name: func,
        args: null,
      }],
    },

    rangeStr(interval, resolution):: if resolution == "" then '[%s]' % interval else '[%s:%s]' % [interval, resolution],
    withRangeVectorFunc(func, interval, resolution):: self {
      functions+: [{
        name: func,
        args: {
          interval: interval,
          resolution: resolution,
        },
      }],
    },

    sum():: self.withInstantVectorFunc("sum"),
    delta(interval, resolution):: self.withRangeVectorFunc("delta", interval, resolution),

    applyFunction(query, func):: std.format('%s(%s%s)', [func.name, query, if func.args == null then "" else self.rangeStr(func.args.interval, func.args.resolution)]),
    applyFunctions(query):: std.foldl(self.applyFunction, self.functions, query),

    baseQuery():: "%s%s" % [metricName, self.labelExpr()],
    build():: self.applyFunctions(self.baseQuery()),
  }
}
