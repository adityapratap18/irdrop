#!/usr/bin/perl
my $numOfArg = @ARGV;
if($numOfArg < 4 || $ARGV[0] eq "-h" || $ARGV[0] eq "-H" || $ARGV[0] eq "-help" || $ARGV[0] eq "-HELP"){
   print "genNodeGraph.pl -row <num>\n";
   print "                -col <num>\n";
   print "                -res <{num1,num2}>\n";
   print "                -nodeRMapFile <output graph file (default is nodeRMap.txt)>\n";
   print "                -nodeLocFile <output nodeMap file (default is nodeLoc.txt)>\n";
}else{
   my ($rows, $cols) = (0, 0);
   my ($minRes, $maxReg) = (1, 2);
   my ($nodeRMapFile, $nodeLocFile) = ("nodeRMap.txt", "nodeLoc.txt");
   for(my $xx=0; $xx<=$#ARGV; $xx++){
       if($ARGV[$xx] eq "-row"){ $rows = $ARGV[$xx+1];}
       if($ARGV[$xx] eq "-col"){ $cols = $ARGV[$xx+1];}
       if($ARGV[$xx] eq "-nodeRMapFile"){ $nodeRMapFile = $ARGV[$xx+1];}
       if($ARGV[$xx] eq "-nodeLocFile"){ $nodeLocFile = $ARGV[$xx+1];}
       if($ARGV[$xx] eq "-res"){ 
          my $resStr = $ARGV[$xx+1];
          $resStr =~ s/\{|\}//g;
          ($minRes, $maxReg) = (split(/\s*\,\s*/,$resStr))[0,1];
       }
   }
   open(WRITE_NODE_RMAP,">$nodeRMapFile");
   open(WRITE_NODE_LOC,">$nodeLocFile");
   

   my %resHash = ();
   my $resRange = $maxReg - $minRes;
   #my $g1 = $g2 = $g3 = $g4 = sprintf("%.2f",$minRes + rand($resRange));
   my $g1 = $g2 = $g3 = $g4 = 0;
   for(my $j=0; $j<$rows; $j++){
       for(my $k=0; $k<$cols; $k++){
           my $node = $rows*$j + $k;
           #print "node:$node\n";
           my $nodeLocX = 50*$k;
           my $nodeLocY = 50*$j;
           print WRITE_NODE_LOC "$node $nodeLocX $nodeLocY\n";
           if($j==0 && $k==0){
              my $c1 = $rows*$j + ($k+1);
              my $c2 = $rows*($j+1) + $k;
              if(exists $resHash{"$node-$c1"}){
                 $g1 = $resHash{"$node-$c1"};
              }else{
                 $g1 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c1"} = $g1;
              }
              if(exists $resHash{"$node-$c2"}){
                 $g2 = $resHash{"$node-$c2"};
              }else{
                 $g2 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c2"} = $g2;
              }
              print WRITE_NODE_RMAP "$node $c1,$g1\n";
              print WRITE_NODE_RMAP "$node $c2,$g2\n";

           }elsif($j==0 && $k==($cols-1)){
              my $c1 = $rows*$j + ($k-1);
              my $c2 = $rows*($j+1) + $k;
              if(exists $resHash{"$c1-$node"}){
                 $g1 = $resHash{"$c1-$node"};
              }else{
                 $g1 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c1-$node"} = $g1;
              }
              if(exists $resHash{"$node-$c2"}){
                 $g2 = $resHash{"$node-$c2"};
              }else{
                 $g2 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c2"} = $g2;
              }
              print WRITE_NODE_RMAP "$node $c1,$g1\n";
              print WRITE_NODE_RMAP "$node $c2,$g2\n";

           }elsif($j==($rows-1) && $k==0){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k+1);
              if(exists $resHash{"$c1-$node"}){
                 $g1 = $resHash{"$c1-$node"};
              }else{
                 $g1 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c1-$node"} = $g1;
              }
              if(exists $resHash{"$node-$c2"}){
                 $g2 = $resHash{"$node-$c2"};
              }else{
                 $g2 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c2"} = $g2;
              }
              print WRITE_NODE_RMAP "$node $c1,$g1\n";
              print WRITE_NODE_RMAP "$node $c2,$g2\n";

           }elsif($j==($rows-1) && $k==($cols-1)){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k-1);
              if(exists $resHash{"$c1-$node"}){
                 $g1 = $resHash{"$c1-$node"};
              }else{
                 $g1 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c1-$node"} = $g1;
              }
              if(exists $resHash{"$c2-$node"}){
                 $g2 = $resHash{"$c2-$node"};
              }else{
                 $g2 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c2-$node"} = $g2;
              }
              print WRITE_NODE_RMAP "$node $c1,$g1\n";
              print WRITE_NODE_RMAP "$node $c2,$g2\n";

           }elsif($j==0 && $k!=0 && $k!=($cols-1)){
              my $c1 = $rows*$j + ($k-1);
              my $c2 = $rows*$j + ($k+1);
              my $c3 = $rows*($j+1) + $k;
              if(exists $resHash{"$c1-$node"}){
                 $g1 = $resHash{"$c1-$node"};
              }else{
                 $g1 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c1-$node"} = $g1;
              }
              if(exists $resHash{"$node-$c2"}){
                 $g2 = $resHash{"$node-$c2"};
              }else{
                 $g2 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c2"} = $g2;
              }
              if(exists $resHash{"$node-$c3"}){
                 $g3 = $resHash{"$node-$c3"};
              }else{
                 $g3 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c3"} = $g3;
              }
              print WRITE_NODE_RMAP "$node $c1,$g1\n";
              print WRITE_NODE_RMAP "$node $c2,$g2\n";
              print WRITE_NODE_RMAP "$node $c3,$g3\n";

           }elsif($j==($rows-1) && $k!=0 && $k!=($cols-1)){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k-1);
              my $c3 = $rows*$j + ($k+1);
              if(exists $resHash{"$c1-$node"}){
                 $g1 = $resHash{"$c1-$node"};
              }else{
                 $g1 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c1-$node"} = $g1;
              }
              if(exists $resHash{"$c2-$node"}){
                 $g2 = $resHash{"$c2-$node"};
              }else{
                 $g2 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c2-$node"} = $g2;
              }
              if(exists $resHash{"$node-$c3"}){
                 $g3 = $resHash{"$node-$c3"};
              }else{
                 $g3 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c3"} = $g3;
              }
              print WRITE_NODE_RMAP "$node $c1,$g1\n";
              print WRITE_NODE_RMAP "$node $c2,$g2\n";
              print WRITE_NODE_RMAP "$node $c3,$g3\n";

           }elsif($j!=0 && $j!=($rows-1) && $k==0){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k+1);
              my $c3 = $rows*($j+1) + $k;
              if(exists $resHash{"$c1-$node"}){
                 $g1 = $resHash{"$c1-$node"};
              }else{
                 $g1 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c1-$node"} = $g1;
              }
              if(exists $resHash{"$node-$c2"}){
                 $g2 = $resHash{"$node-$c2"};
              }else{
                 $g2 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c2"} = $g2;
              }
              if(exists $resHash{"$node-$c3"}){
                 $g3 = $resHash{"$node-$c3"};
              }else{
                 $g3 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c3"} = $g3;
              }
              print WRITE_NODE_RMAP "$node $c1,$g1\n";
              print WRITE_NODE_RMAP "$node $c2,$g2\n";
              print WRITE_NODE_RMAP "$node $c3,$g3\n";

           }elsif($j!=0 && $j!=($rows-1) && $k==($cols-1)){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k-1);
              my $c3 = $rows*($j+1) + $k;
              if(exists $resHash{"$c1-$node"}){
                 $g1 = $resHash{"$c1-$node"};
              }else{
                 $g1 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c1-$node"} = $g1;
              }
              if(exists $resHash{"$c2-$node"}){
                 $g2 = $resHash{"$c2-$node"};
              }else{
                 $g2 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c2-$node"} = $g2;
              }
              if(exists $resHash{"$node-$c3"}){
                 $g3 = $resHash{"$node-$c3"};
              }else{
                 $g3 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c3"} = $g3;
              }
              print WRITE_NODE_RMAP "$node $c1,$g1\n";
              print WRITE_NODE_RMAP "$node $c2,$g2\n";
              print WRITE_NODE_RMAP "$node $c3,$g3\n";

           }else{
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k-1);
              my $c3 = $rows*$j + ($k+1);
              my $c4 = $rows*($j+1) + $k;
              if(exists $resHash{"$c1-$node"}){
                 $g1 = $resHash{"$c1-$node"};
              }else{
                 $g1 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c1-$node"} = $g1;
              }
              if(exists $resHash{"$c2-$node"}){
                 $g2 = $resHash{"$c2-$node"};
              }else{
                 $g2 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$c2-$node"} = $g2;
              }
              if(exists $resHash{"$node-$c3"}){
                 $g3 = $resHash{"$node-$c3"};
              }else{
                 $g3 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c3"} = $g3;
              }
              if(exists $resHash{"$node-$c4"}){
                 $g4 = $resHash{"$node-$c4"};
              }else{
                 $g4 = sprintf("%.2f",$minRes + rand($resRange));
                 $resHash{"$node-$c4"} = $g4;
              }
              print WRITE_NODE_RMAP "$node $c1,$g1\n";
              print WRITE_NODE_RMAP "$node $c2,$g2\n";
              print WRITE_NODE_RMAP "$node $c3,$g3\n";
              print WRITE_NODE_RMAP "$node $c4,$g4\n";

           }
       }
   }
   close(WRITE_NODE_LOC);
   close(WRITE_NODE_RMAP);
}
