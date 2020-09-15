set linesize 80
qui use "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\Allbus2018.dta", clear
qui mvdecode di05, mv(-50 -32 -7)
fastgini di05 if eastwest == 2
