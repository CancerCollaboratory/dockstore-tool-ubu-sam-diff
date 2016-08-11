#!/usr/bin/env cwl-runner

class: CommandLineTool

dct:creator:
  foaf:name: Andy Yang
  foaf:mbox: mailto:ayang@oicr.on.ca
cwlVersion: v1.0

requirements:
- class: DockerRequirement
  dockerPull: quay.io/cancercollaboratory/dockstore-tool-ubu-sam-diff
inputs:
  out1:
    type: string
    inputBinding:
      position: 4
      prefix: --out1
    doc: Output SAM/BAM file containing reads unique to input file 1
  out2:
    type: string
    inputBinding:
      position: 5
      prefix: --out2
    doc: Output SAM/BAM file containing reads unique to input file 2
  in1:
    type: File
    inputBinding:
      position: 1
      prefix: --in1
    doc: Input SAM/BAM file 1 sorted by read
  in2:
    type: File
    inputBinding:
      position: 2
      prefix: --in2
    doc: Input SAM/BAM file 2 sorted by read
  ids-only:
    type: string?
    inputBinding:
      position: 3

    doc: If specified, compare read id only. Otherwise, entire read is compared
outputs:
  out1:
    type: File
    outputBinding:
      glob: $(inputs.out1)

    doc: Output SAM/BAM file containing reads unique to input file 1
  out2:
    type: File
    outputBinding:
      glob: $(inputs.out2)

    doc: Output SAM/BAM file containing reads unique to input file 2
baseCommand: [java, -jar, /opt/ubu/ubu.jar, sam-diff]
doc: |
  Diff two SAM/BAM files outputting discrepant reads in corresponding SAM/BAM files

