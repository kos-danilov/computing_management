class: Workflow
cwlVersion: v1.0

requirements:
  ScatterFeatureRequirement: {}

inputs:
  pattern: string
  in_file: File[]

outputs:
  out_file: 
    type: File
    outputSource: count/outfile

steps:
  grep:
    scatter: in_file
    run: gerp.cwl
    in:
      pattern: pattern
      infile: in_file
    out:
      [outfile]
  count:
    run: wc.cwl
    in:
      infile: grep/outfile
    out:
      [outfile]