#!/usr/bin/env cwl-runner

class: CommandLineTool

description: |
  Diff two SAM/BAM files outputting discrepant reads in corresponding SAM/BAM files

dct:creator:
  foaf:name: Andy Yang
  foaf:mbox: "mailto:ayang@oicr.on.ca"

cwlVersion: draft-3

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/cancercollaboratory/dockstore-tool-ubu-sam-diff"

inputs:
  - id: "#in1"
    type: File
    description: "Input SAM/BAM file 1 sorted by read"
    inputBinding:
      position: 1
      prefix: "--in1"


  - id: "#in2"
    type: File
    description: "Input SAM/BAM file 2 sorted by read"
    inputBinding:
      position: 2
      prefix: "--in2"

  - id: "#out1"
    type: string 
    description: "Output SAM/BAM file containing reads unique to input file 1"
    inputBinding:
      position: 4 
      prefix: "--out1"


  - id: "#out2"
    type: string 
    description: "Output SAM/BAM file containing reads unique to input file 2"
    inputBinding:
      position: 5 
      prefix: "--out2"

  - id: "#ids-only"
    type: [ "null", string ]
    description: "If specified, compare read id only. Otherwise, entire read is compared"
    inputBinding:
      position: 3

outputs:
  - id: "#out1"
    type: File
    description: "Output SAM/BAM file containing reads unique to input file 1"
    outputBinding: 
      glob: $(inputs.out1)

  - id: "#out2"
    type: File
    description: "Output SAM/BAM file containing reads unique to input file 2"
    outputBinding: 
      glob: $(inputs.out2)

baseCommand: ["java" , "-jar" , "/opt/ubu/ubu.jar" , "sam-diff" ]
