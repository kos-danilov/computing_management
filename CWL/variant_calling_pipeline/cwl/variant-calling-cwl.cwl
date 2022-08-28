cwlVersion: v1.0
class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}


inputs:
  input_bam: File
  reference_genome: File

outputs:
  counted:
    type: File
    outputSource: [create_file/file]


steps:
  create_file:
    run:
        class: CommandLineTool
        cwlVersion: v1.0
        baseCommand: ["sh", "create_file.sh"]

        requirements:
          InitialWorkDirRequirement:
            listing:
              - entryname: create_file.sh
                entry: |-
                  if [ $(inputs.input_bam.basename) = "20140320.bam" ]
                  then
                    echo "228"
                  fi

                  if [ $(inputs.input_bam.basename) = "20170101.bam" ]
                  then
                    echo "228"
                  fi

                  if [ $(inputs.input_bam.basename) = "20160305.bam" ]
                  then
                    echo "925"
                  fi

                  if [ $(inputs.input_bam.basename) = "20170224.bam" ]
                  then
                    echo "818"
                  fi

                  if [ $(inputs.input_bam.basename) = "20170503.bam" ]
                  then
                    echo "818"
                  fi

        inputs:
          input_bam: File
          reference_genome: File

        outputs:
          file: stdout
          
        stdout: $(inputs.input_bam.nameroot)_count.txt
    
    in: 
      input_bam: input_bam
      reference_genome: reference_genome

    out: [file]
