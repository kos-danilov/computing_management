class: CommandLineTool
cwlVersion: v1.0
baseCommand: ["sh", "example.sh"]

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: example.sh
        entry: |-
          NAME=`cat $(inputs.file.path)`
          printf "Hello \${NAME}!"

inputs:
  file:
    type: File
    inputBinding:
      position: 1

outputs:
  output:
    type: stdout

stdout: $(inputs.file.basename)