; Script for program DISTRIBUTION in file "D:\2ND SEMESTER M TECH\STUDIO_LAB\CUBE FINAL\CUBE_DISTRIBUTION_01-04-2024\12DST00B.S"
;;<<Default Template>><<DISTRIBUTION>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=DISTRIBUTION PRNFILE="D:\2ND SEMESTER M TECH\STUDIO_LAB\CUBE FINAL\CUBE_DISTRIBUTION_01-04-2024\12DST00B.PRN"
FILEI MATI[1] = "D:\2ND SEMESTER M TECH\STUDIO_LAB\CUBE FINAL\CUBE_DISTRIBUTION_01-04-2024\15MAT00B.MAT"
FILEI ZDATI[1] = "D:\2ND SEMESTER M TECH\STUDIO_LAB\CUBE FINAL\CUBE_DISTRIBUTION_01-04-2024\12GEN00B.DAT"
FILEO MATO[1] = "D:\2ND SEMESTER M TECH\STUDIO_LAB\CUBE FINAL\CUBE_DISTRIBUTION_01-04-2024\12DST00B.MAT",
MO=1, DEC=0, NAME=PA


  PAR maxiters=99, maxrmse =1
  SETPA p[1]=zi.1.PROD,A[1]=zi.1.ATTR 
  ZONES=11
;;; LOOK UP FUNCTION DECLARATION;;;;;;;;;
  LOOKUP NAME=FF,; Gamma Function Parameters
  LOOKUP[1]=1, RESULT=2, ; ALPHA VALUE
  LOOKUP[2]=1, RESULT=3, ; BETA VALUE
  INTERPOLATE=N, ; No Interpolation needed on purpose
    R=' 1 -0.897392 -0.0255572'
;Putting Time Values in working matrices mw [11] = mi * 0.1 * 0.1 ; Highway time
  mw[8]=mi.1.1 ; highway time
 IF(i<12)
LOOP INC=1,1
alpha=FF(1,INC)
beta=FF(2,INC)
TSKIM=INC+10 ;Input Time Skim to MW [11] to MW[14]
GSKIM=INC+20 ;Output Gamma (Friction factors) Skim
;PUT GAMMA MATRICES IN MW[21]
mw[GSKIM]=mw[tskim]^alpha*(exp(beta*mw[TSKIM]))
ENDLOOP
;Trip Distribution Step
LOOP PURP=1,1; creates MW[1]
PAF=0
MW[PURP] = A[PURP] * MW[PURP+20]
ATTRSUM=ROWSUM(PURP)
IF (ATTRSUM>0) PAF=P[PURP]/ATTRSUM
MW [PURP]=PAF * MW[PURP]
ENDLOOP
ENDIF
FREQUENCY VALUEMW=21 BASEMW=11, RANGE=1-60-6, 
TITLE='** PA **'


; The DISTRIBUTION module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  The module has a built in GRAVITY statement for implementing this commonly
; used distribution method.  User defined distribution process can also be defined.

ENDRUN

