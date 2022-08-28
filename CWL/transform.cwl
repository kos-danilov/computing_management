#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: "v1.0"

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: example.sh
        entry: |-
          #!/bin/bash

          filename=`echo $(inputs.infile.location) | awk '{ split($0,array,"://")} END{print array[2]}'`

          cat $filename | \
            awk -F '' '{n=split($0,a,""); for (i=1;i<=n;i++) { print(a[i]); } exit;}' | \
            sort | \
            uniq -c | \
            awk 'BEGIN { print "{\\n    \\"string_list\\": ["} { print "        \\""$2 ":", $1 "\\"," } END { print "    ]\\n}"}' | \
            sed ':a;N;$!ba;s/,\\n    ]/\\n    ]/g'

inputs:
  infile:
    type: File

outputs:
  string_list: string[]

baseCommand: ["sh", "example.sh"]
stdout: cwl.output.json