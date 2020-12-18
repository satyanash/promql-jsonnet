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
    },
    withRange(interval):: self {
      range+: {
        interval: interval,
      },
    },
    rangeStr():: if self.range.interval == "" then "" else '[%s]' % self.range.interval,

    build():: "%s%s%s" % [metricName, self.labelExpr(), self.rangeStr()],
  }
}
