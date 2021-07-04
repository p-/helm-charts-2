#!/bin/bash -e

runSemanticRelease() {
  cp .releaserc.json "$1"
  export CHART_NAME=${1#charts/}
  echo "{\"name\":\"$CHART_NAME\"}" >"$1/package.json"
  DIR_PATH=$(pwd)
  cd "$1" || exit
  "$DIR_PATH/node_modules/.bin/semantic-release"

  cd ../..
}

echo "[Script] Running semantic-release for charts/common"
runSemanticRelease "charts/common"

for chart in charts/*; do
  echo "[Script] Running semantic-release for $chart"
  runSemanticRelease "$chart"
done
