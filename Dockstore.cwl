#!/usr/bin/env cwl-runner

class: CommandLineTool

description: |
Diff two SAM/BAM files outputting discrepant reads in corresponding SAM/BAM files

dct:creator:
  foaf:name: Andy Yang
  foaf:mbox: "mailto:ayang@oicr.on.ca"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/cancercollaboratory/dockstore-tool-ubu-sam-diff"
  - { import: node-engine.cwl }

inputs:
  - id: "#in1"
    type: File
    description: "Input SAM/BAM file 1 sorted by read"
    inputBinding:
      position: 1

  - id: "#in2"
    type: File
    description: "Input SAM/BAM file 2 sorted by read"
    inputBinding:
      position: 2

  - id: "#ids-only"
    type: string
    description: "If specified, compare read id only. Otherwise, entire read is compared"
    inputBinding:
      position: 3

outputs:
  - id: "#out1"
    type: File
    description: "Output SAM/BAM file containing reads unique to input file 1"
    outputBinding:
      glob:
        engine: cwl:JsonPointer
        script: /job/output1

  - id: "#out2"
    type: File
    description: "Output SAM/BAM file containing reads unique to input file 2"
    outputBinding:
      glob:
        engine: cwl:JsonPointer
        script: /job/output2


baseCommand: ["sam-diff"]
