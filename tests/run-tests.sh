#!/bin/bash

# run's all the available tests

for test in */; do
    if [ ! -x "${test}/run.sh" ]; then
        continue
    fi

    testName="${test%/}"

    LOGFILE=/tmp/sanoid_test_run_"${testName}".log

    pushd . > /dev/null

    echo -n "Running test ${testName} ... "
    cd "${test}"
    echo -n y | bash run.sh > "${LOGFILE}" 2>&1

    ret=$?
    if [ $ret -eq 0 ]; then
        echo "[PASS]"
    elif [ $ret -eq 130 ]; then
        echo "[SKIPPED]"
    else
        echo "[FAILED] (see ${LOGFILE})"
    fi

    popd > /dev/null
done
