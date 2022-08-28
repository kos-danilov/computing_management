cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: [$(inputs.bcf)]

baseCommand: []

arguments:
  - bcftools 
  - view 
  - -vcg
  - $(inputs.bcf.basename)

inputs:
  bcf:
    type: File

outputs:
  vcf:
    type: stdout
      
stdout: variants_samtools.vcf