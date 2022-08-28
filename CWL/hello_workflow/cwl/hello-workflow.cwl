class: Workflow
cwlVersion: v1.0

requirements:
  ScatterFeatureRequirement: {}

inputs:
  input_dir: Directory

outputs:
  output: 
    type: File[]
    outputSource: cat/output

steps:
  get:
    run: get.cwl
    in:
      input_dir: input_dir
    out:
      [outfiles]
  cat:
    scatter: file
    run: cat.cwl
    in:
      file: get/outfiles
    out:
      [output]