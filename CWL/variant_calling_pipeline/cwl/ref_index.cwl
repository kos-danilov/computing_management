cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: [$(inputs.reference)]

baseCommand: []

arguments:
  - samtools
  - faidx
  - $(inputs.reference.basename)

inputs:
  reference:
    type: File

outputs:
  reference_with_index:
    type: File
    secondaryFiles:
      - .fai
    outputBinding:
      glob: $(inputs.reference.basename)

  # reference_index:
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.reference.basename).fai