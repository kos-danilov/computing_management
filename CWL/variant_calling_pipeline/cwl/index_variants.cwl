cwlVersion: v1.0
class: Workflow

inputs:
  variants: File

outputs:
#   variants_compressed:
#     type: File
#     outputSource: gunzip/variants_compressed
  variants_sorted:
    type: File
    outputSource: index/variants_sorted

steps:
  gunzip:
    run: 
      class: CommandLineTool

      requirements:
        ShellCommandRequirement: {}
        InitialWorkDirRequirement:
          listing: [$(inputs.variants)]

      arguments:
        - valueFrom: "bgzip $(inputs.variants.basename)"
          shellQuote: false

      inputs:
        variants:
          type: File
        
      outputs:
        variants_compressed:
          type: File
          outputBinding:
            glob: $(inputs.variants.basename).gz

    in:
      variants: variants

    out: [variants_compressed]

  index:
    run: 
      class: CommandLineTool

      requirements:
        ShellCommandRequirement: {}
        InitialWorkDirRequirement:
          listing: [$(inputs.variants_compressed)]

      arguments:
        - valueFrom: "tabix -p vcf $(inputs.variants_compressed.basename)"
          shellQuote: false

      inputs:
        variants_compressed:
          type: File
        
      outputs:
        variants_sorted:
          type: File
          outputBinding:
            glob: $(inputs.variants_compressed.basename)
          secondaryFiles:
            - .tbi
      
    in:
      variants_compressed: gunzip/variants_compressed
    out: [variants_sorted]