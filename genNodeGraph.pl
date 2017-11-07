#!/usr/bin/perl
my $numOfArg = @ARGV;
if($numOfArg < 4 || $ARGV[0] eq "-h" || $ARGV[0] eq "-H" || $ARGV[0] eq "-help" || $ARGV[0] eq "-HELP"){
   print "genNodeGraph.pl -row <num>\n";
   print "                -col <num>\n";
   print "                -res <{num1,num2}>\n";
   print "                -gFile <output graph file (default is data.txt)>\n";
   print "                -nodeMapFile <output nodeMap file (default is nodeMap.txt)>\n";
}else{
   #my @conn = ();
   my ($rows, $cols) = (0, 0);
   my ($minRes, $maxReg) = (1, 2);
   my ($graphFile, $nodeMapFile) = ("data.txt", "nodeMap.txt");
   for(my $xx=0; $xx<=$#ARGV; $xx++){
       if($ARGV[$xx] eq "-row"){ $rows = $ARGV[$xx+1];}
       if($ARGV[$xx] eq "-col"){ $cols = $ARGV[$xx+1];}
       if($ARGV[$xx] eq "-gFile"){ $graphFile = $ARGV[$xx+1];}
       if($ARGV[$xx] eq "-nodeMapFile"){ $nodeMapFile = $ARGV[$xx+1];}
       if($ARGV[$xx] eq "-res"){ 
          my $resStr = $ARGV[$xx+1];
          $resStr =~ s/\{|\}//g;
          ($minRes, $maxReg) = (split(/\s*\,\s*/,$resStr))[0,1];
       }
   }
   open(WRITE,">$graphFile");
   print WRITE "############################################################################\n";
   print WRITE "# Positive sign for current entering the node				   #\n";
   print WRITE "# Negative sign for current leaving the node				   #\n";
   print WRITE "# Use x if not applicable (e.g. node has less than 4 neighboring nodes     #\n";
   print WRITE "# Node	I(A)	node1,g1	node2,g2	node3,g3	node4,g4   #\n";
   print WRITE "############################################################################\n";

   open(WRITE1,">$nodeMapFile");
   print WRITE1 "Row,Col =>   Node\n";
   print WRITE1 "---------------\n";

   my %resHash = ();
   my $resRange = $maxReg - $minRes;
   #my $g1 = $g2 = $g3 = $g4 = sprintf("%.2f",$minRes + rand($resRange));
   my $g1 = $g2 = $g3 = $g4 = 0;
   for(my $j=0; $j<$rows; $j++){
       for(my $k=0; $k<$cols; $k++){
           my $node = $rows*$j + $k;
           #print "node:$node\n";
           print WRITE1 "$j,$k     =>   $node\n";
           if($j==0 && $k==0){
              my $c1 = $rows*$j + ($k+1);
              my $c2 = $rows*($j+1) + $k;
              #push(@conn, "$node-$c1", "$node-$c2"); 
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
              print WRITE "$node		$c1,$g1		$c2,$g2		x,x		x,x\n";

           }elsif($j==0 && $k==($cols-1)){
              my $c1 = $rows*$j + ($k-1);
              my $c2 = $rows*($j+1) + $k;
              #push(@conn, "$node-$c1", "$node-$c2"); 
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
              print WRITE "$node		$c1,$g1		$c2,$g2		x,x		x,x\n";

           }elsif($j==($rows-1) && $k==0){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k+1);
              #push(@conn, "$node-$c1", "$node-$c2"); 
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
              print WRITE "$node		$c1,$g1		$c2,$g2		x,x		x,x\n";

           }elsif($j==($rows-1) && $k==($cols-1)){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k-1);
              #push(@conn, "$node-$c1", "$node-$c2"); 
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
              print WRITE "$node		$c1,$g1		$c2,$g2		x,x		x,x\n";

           }elsif($j==0 && $k!=0 && $k!=($cols-1)){
              my $c1 = $rows*$j + ($k-1);
              my $c2 = $rows*$j + ($k+1);
              my $c3 = $rows*($j+1) + $k;
              #push(@conn, "$node-$c1", "$node-$c2", "$node-$c3"); 
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
              print WRITE "$node		$c1,$g1		$c2,$g2		$c3,$g3		x,x\n";

           }elsif($j==($rows-1) && $k!=0 && $k!=($cols-1)){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k-1);
              my $c3 = $rows*$j + ($k+1);
              #push(@conn, "$node-$c1", "$node-$c2", "$node-$c3"); 
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
              print WRITE "$node		$c1,$g1		$c2,$g2		$c3,$g3		x,x\n";

           }elsif($j!=0 && $j!=($rows-1) && $k==0){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k+1);
              my $c3 = $rows*($j+1) + $k;
              #push(@conn, "$node-$c1", "$node-$c2", "$node-$c3"); 
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
              print WRITE "$node		$c1,$g1		$c2,$g2		$c3,$g3		x,x\n";

           }elsif($j!=0 && $j!=($rows-1) && $k==($cols-1)){
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k-1);
              my $c3 = $rows*($j+1) + $k;
              #push(@conn, "$node-$c1", "$node-$c2", "$node-$c3"); 
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
              print WRITE "$node		$c1,$g1		$c2,$g2		$c3,$g3		x,x\n";

           }else{
              my $c1 = $rows*($j-1) + $k;
              my $c2 = $rows*$j + ($k-1);
              my $c3 = $rows*$j + ($k+1);
              my $c4 = $rows*($j+1) + $k;
              #push(@conn, "$node-$c1", "$node-$c2", "$node-$c3", "$node-$c4"); 
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
              print WRITE "$node		$c1,$g1		$c2,$g2		$c3,$g3		$c4,$g4\n";

           }
       }
   }
   close(WRITE1);
   close(WRITE);
   #print "@conn\n";
}
