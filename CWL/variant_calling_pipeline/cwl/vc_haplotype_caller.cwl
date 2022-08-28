class: CommandLineTool
cwlVersion: v1.0

requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing: [$(inputs.reference), $(inputs.bam), $(inputs.dict)]

baseCommand: []

arguments:
  - valueFrom: "java -jar /opt/gatk/GenomeAnalysisTK.jar -R $(inputs.reference.basename) -T HaplotypeCaller -I $(inputs.bam.basename) -o variants_haplotype_caller.vcf"
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
  dict:
    type: File

outputs:
  variants_haplotype_caller:
    type: File
    outputBinding: 
      glob: variants_haplotype_caller.vcf