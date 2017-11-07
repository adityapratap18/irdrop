#How to run the irdrop calculation

curl -s -X POST http://52.52.201.31:8092/irdrop -F 'fileW=@nodeRMap.txt' -F 'fileX=@nodeCurrentMap.txt' -F 'fileY=@voltageSources.txt' -F 'fileZ=@nodeLoc.txt' -F 'token=demo'
