class: Workflow
cwlVersion: v1.0

requirements:
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  input_bam: File
  reference_genome: File

outputs:
  # reference_index:
  #   type: File
  #   outputSource: ref_index/reference_with_index

  # ref_dict:
  #   type: File
  #   outputSource: ref_dict/reference_dic

  # bam_index:
  #   type: File
  #   outputSource: bam_index/bam_with_index

  # variants_samtools:
  #   type: File
  #   outputSource: samtools/variants_samtools

  # variants_samtools_vcf:
  #   type: File
  #   outputSource: bcf2vcf/vcf

  # variants_freebayes:
  #   type: File
  #   outputSource: freebayes/variants_freebayes

  # variants_haplotype_caller:
  #   type: File
  #   outputSource: haplotype_caller/variants_haplotype_caller

  # variants_index:
  #   type: File[]
  #   outputSource: [variants_index/variants_sorted]

  # variants_intersected:
  #   type: File
  #   outputSource: [intersect/common_variants]

  counted:
    type: File
    outputSource: [count/counted]


steps:
  ref_index:
    run: ref_index.cwl
    in:
      reference: reference_genome
    out: [reference_with_index]
  
  ref_dict:
    run: sequence_dic.cwl
    in:
      reference: reference_genome
    out: [reference_dic]

  bam_index:
    run: index_bam.cwl
    in:
      bam: input_bam
    out: [bam_with_index]

  samtools:
    run: vc_samtools.cwl
    in:
      bam: bam_index/bam_with_index
      reference: ref_index/reference_with_index
    out: [variants_samtools]

  bcf2vcf:
    run: bcf2vcf.cwl
    in:
      bcf: samtools/variants_samtools
    out: [vcf]

  freebayes:
    run: vc_freebayes.cwl
    in:
      bam: bam_index/bam_with_index
      reference: ref_index/reference_with_index
    out: [variants_freebayes]

  haplotype_caller:
    run: vc_haplotype_caller.cwl
    in:
      bam: bam_index/bam_with_index
      reference: ref_index/reference_with_index
      dict: ref_dict/reference_dic
    out: [variants_haplotype_caller]

  variants_index:
    run: index_variants.cwl
    scatter: variants
    in:
      variants: [bcf2vcf/vcf, freebayes/variants_freebayes, haplotype_caller/variants_haplotype_caller]
    out: [variants_sorted]

  intersect:
    run: intersect_variants.cwl
    in:
      variants: variants_index/variants_sorted
    out: [common_variants]

  count:
    run:
      class: CommandLineTool

      requirements:
        ShellCommandRequirement: {}
        InitialWorkDirRequirement:
          listing: [$(inputs.common_variants), $(inputs.name)]

      
      arguments:
        - valueFrom: "grep '^[^#]' -c $(inputs.common_variants.basename)"
          shellQuote: false

      inputs:
        common_variants: File
        name: File
      
      outputs:
        counted:
          type: stdout
      
      stdout: $(inputs.name.nameroot)_count.txt

    in:
      common_variants: intersect/common_variants
      name: input_bam

    out: [counted]