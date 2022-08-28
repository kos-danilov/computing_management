class: ExpressionTool
cwlVersion: v1.0

requirements:
  - class: InlineJavascriptRequirement

inputs:
  input_dir: Directory

outputs:
  outfiles: File[]

expression: |
  ${
    var file_array = inputs.input_dir.listing;
    return { "outfiles": file_array.filter(function(file) {return !/^\./.test(file.basename)})};
  }