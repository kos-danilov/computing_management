cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["sh", "example.sh"]

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: example.sh
        entry: |-
          wc -w $(inputs.input_file.path) | awk '{print $1}'
  
inputs:
  input_file:
    type: File

outputs:
  output_file:
    type: stdout

stdout: output

# cwlVersion: v1.0
# class: CommandLineTool
# requirements:
#   - class: ShellCommandRequirement

# inputs:
#   input_file:
#     type: File

# outputs:
#   output_file:
#     type: File
#     outputBinding:
#       glob: output/output

# stdout: output/output

# baseCommand: []
# arguments:
#   - wc
#   - -w
#   - $(inputs.input_file)
#   - '|'
#   - awk
#   - '{print $1;}'


# cwlVersion: v1.0
# class: CommandLineTool
# requirements:
#   - class: ShellCommandRequirement
# inputs:
#   input_file:
#     type: File
# outputs:
#   out_file:
#     type: File
#     outputBinding:
#       glob: output
# stdout: output
# baseCommand: []
# arguments:
#   - valueFrom: "cat $(inputs.input_file.path) | wc -w"
#     shellQuote: false