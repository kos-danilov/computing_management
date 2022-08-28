class: CommandLineTool
cwlVersion: v1.0

requirements:
  InitialWorkDirRequirement:
    listing: [$(inputs.reference), $(inputs.bam)]

baseCommand: []

arguments:
  - freebayes
  - -f

inputs:
  reference:
    type: File
    secondaryFiles:
      - .fai
    inputBinding:
      position: 1
  bam:
    type: File
    secondaryFiles:
      - .bai
    inputBinding:
      position: 2

outputs:
  variants_freebayes:
    type: stdout

stdout: variants_freebayes.vcf