find . -mindepth 1 | grep -vE 'run.sh|reset.sh|input.json|.*\.circom$' | xargs rm -rf
