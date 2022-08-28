cwlVersion: v1.0
class: CommandLineTool

requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    # listing: [$(inputs.v_samtools), $(inputs.v_freebayes), $(inputs.v_haplotypecaller)]
    listing: [$(inputs.variants)]


# baseCommand: []
baseCommand: ["vcf-isec", "-f", "-n", "+2"]

# arguments:
#   - valueFrom: "vcf-isec -f -n +2 $(inputs.variants.basename)"
#     shellQuote: false

# arguments:
#   - valueFrom: "vcf-isec -f -n +2 $(inputs.v_samtools.basename) $(inputs.v_freebayes.basename) $(inputs.v_haplotypecaller.basename)"
#     shellQuote: false

inputs:
  variants:
    type: File[]
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 1
#   v_samtools:
#     type: File
#     secondaryFiles:
#     - .tbi
#   v_freebayes:
#     type: File
#     secondaryFiles:
#     - .tbi
#   v_haplotypecaller:
#     type: File
#     secondaryFiles:
#     - .tbi

outputs:
  common_variants:
    type: stdout

stdout: common_variants.vcf
