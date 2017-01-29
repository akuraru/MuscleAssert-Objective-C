#!/bin/sh

xcodebuild test -workspace MuscleAssert.xcworkspace \
-scheme 'Test' \
-sdk iphonesimulator \
-destination 'platform=iOS Simulator,name=iPhone 6s' \
GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
GCC_GENERATE_TEST_COVERAGE_FILES=YES
