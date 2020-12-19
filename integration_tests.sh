#!/bin/bash

TEST_RUN=test_run.sh

FAILURE_COUNT=0
TEST_COUNT=0

rm ${TEST_RUN}

cat <<EOF >> ${TEST_RUN}
#!/bin/bash
source "./test_utils.sh"

EOF

jsonnet tests.jsonnet | jq -r ".[] | \"promql_test '\" + .[0] + \"' '\" + .[1] + \"' ;\"" >> ${TEST_RUN}

cat <<EOF >> ${TEST_RUN}

if [[ \$FAILURE_COUNT > 0 ]]; then
    echo "FAILURES: \$FAILURE_COUNT"
    exit 1;
else
    echo "OK: \$TEST_COUNT"
fi
EOF


source ${TEST_RUN}
