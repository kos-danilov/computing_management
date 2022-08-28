cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: [$(inputs.bam)]

baseCommand: []

arguments:
  - samtools
  - index
  - $(inputs.bam.basename)

inputs:
  bam:
    type: File

outputs:
  bam_with_index:
    type: File
    secondaryFiles:
      - .bai
    outputBinding:
      glob: $(inputs.bam.basename)

#   bam_index:
#     type: File
#     outputBinding: 
#       glob: $(inputs.bam.basename).bai