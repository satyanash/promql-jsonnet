#!/bin/bash

function check_query(){
    local query=$1
    curl -s -o /dev/null -X POST \
         'http://localhost:9090/api/v1/query' \
         --data "query=${query}" \
         -w "%{http_code}"
}

function get_error(){
    local query=$1
    curl -s -X POST \
         'http://localhost:9090/api/v1/query' \
         --data "query=${query}" | jq "."
}

function promql_test() {
    local description=$1
    local query=$2

    local status_code=$(check_query "${query}")

    if [[ $status_code != "200" ]]; then
        local error=$(get_error "${query}");
        echo "FAILED: ${description}";
        echo " QUERY: ${query}";
        echo " ERROR: ${error}";
        FAILURE_COUNT=$((FAILURE_COUNT+1));
    fi
    TEST_COUNT=$((TEST_COUNT+1))
}
