#Switches Azure subscription when parameter specified
#Author: Simon Taggart
#Last Modified: 12/03/2020

param ($sub = 'sandbox') #Default will be Sandbox if no parameter specified
switch($sub){
 'sandbox' {Set-AzContext ed89df52-d2d3-4790-bf82-ebf1a17fb97b}
 'prod' {Set-AzContext 5bc887aa-fa08-4562-9edd-2823b68a5931} 
 'nonprod' {Set-AzContext 5ef52648-991e-4cc7-8750-a2b39424a799}
 'personal' {Set-AzContext 2947ef02-9dc7-4a02-b0e4-42c2499f28d5}
 'dev' {Set-AzContext 7f2c0ab5-6acc-4a23-84b2-9fa4c3d22bb4}
 }