#!/bin/bash

set -euxo pipefail

export GREYMATTER_CATALOG_MESH=my-mesh

mkdir -p zone-0
mkdir -p zone-1

greymatter export-zone zone-0 -c $PWD/.greymatter.yaml | python3 fabric_script.py $PWD/zone-0
greymatter export-zone zone-1 -c $PWD/.greymatter.yaml | python3 fabric_script.py $PWD/zone-1
greymatter get catalog-mesh my-mesh -c $PWD/.greymatter.yaml | python3 catalog_mesh_script.py $PWD
greymatter list catalog-service -c $PWD/.greymatter.yaml | python3 catalog_service_script.py $PWD

git add .
git commit -m 'update'
git push
