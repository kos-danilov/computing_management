class: CommandLineTool
cwlVersion: v1.0

requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing: [$(inputs.reference), $(inputs.bam)]

baseCommand: []

arguments:
  - valueFrom: "samtools mpileup -uf $(inputs.reference.basename) $(inputs.bam.basename)"
    shellQuote: false

inputs:
  reference:
    type: File
    secondaryFiles:
      - .fai
  bam:
    type: File
    secondaryFiles:
      - .bai

outputs:
  variants_samtools:
    type: stdout

stdout: variants_samtools.bcf