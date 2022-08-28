cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing: [$(inputs.reference)]

baseCommand: []

arguments:
  - java
  - -jar
  - /opt/picard/picard.jar
  - CreateSequenceDictionary
  - R=$(inputs.reference.basename)
  - O=$(inputs.reference.nameroot).dict

inputs:
  reference:
    type: File

outputs:
  reference_dic:
    type: File
    outputBinding: 
      glob: $(inputs.reference.nameroot).dict