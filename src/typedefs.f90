MODULE TypeDefs

  INTEGER, PARAMETER :: dp = SELECTED_REAL_KIND(12)
  INTEGER, PARAMETER :: sp = SELECTED_REAL_KIND(6,37)
  REAL(KIND=dp) :: part_expand=0.5
  INTEGER :: myid, ntasks
  LOGICAL :: DebugMode,PrintTimes

  INCLUDE 'param.dat'

  !Types are defined here to save passing large numbers of arguments.
  !Type members refer to the arrays belonging to partitions:
  !M = 'mine', F,B,R,L = Forward, Back, Right, Left, etc

  TYPE NAN_t
     INTEGER :: M(3,NOCON), L(3,NOMA), R(3,NOMA), F(3,NOMA), B(3,NOMA), &
          FR(3,NOMA), FL(3,NOMA), BR(3,NOMA), BL(3,NOMA)
  END TYPE NAN_t

  TYPE NTOT_t
     INTEGER :: M=0, L=0, R=0, F=0, B=0, FR=0, FL=0, BR=0, BL=0
  END TYPE NTOT_t
  
  !Structure for holding initial position of this partition's points, as well
  !as relevant neighbouring [C]onnected and [P]roximal points.
  !Note that %C & %P are not currently in use.
  !NB: The %NP member, in particular, represents the *size* 
  ! of the array (from first to last active member)
  ! which may contain proximal points, but NOT the total number of proximal 
  ! points at any given time (because some may be invalid) - check for PartInfo == -1
  TYPE NRXF_t
     REAL(KIND=dp), ALLOCATABLE :: A(:,:)
     REAL(KIND=dp), POINTER :: M(:,:)=>NULL(), C(:,:)=>NULL(), P(:,:)=>NULL()
     INTEGER :: mstrt, cstrt, pstrt,NN,NC,NP
     INTEGER, ALLOCATABLE :: PartInfo(:,:)
  END TYPE NRXF_t

  !Type to hold information on particles shared between partitions
  !Our partition receives 'CCount' connected and 'PCount' proximal particles
  !from partition 'NID'. The other partition's particle numbers for these are
  !stored in ConnIDs and ProxIDs respectively, and the corresponding array values
  !in ConnLocs and ProxLocs give the array addresses of NRXF (and UT, UTM) to which
  !these shared particles correspond. NID is in fact redundant because HiDEM allocates
  !an array InvPartInfo(0:ntasks-1), where InvPartInfo(i) % NID = i.
  !Thus, if InvPartInfo(3) % ConnIDs(1) = 13, and % ConnLocs(1) = 2459, this means:
  !Partition 3's 13th particle is shared with this partition, and its initial position
  !and displacement is stored in NRXF(:,2459) and UT(2459) respectively.
  !
  !Inverse information (connected and proximal particles *sent* to partition i are
  !stored in SConnIDs(:), SProxIDs(:), SCCount, SPCount
  TYPE InvPartInfo_t
     INTEGER, ALLOCATABLE :: ConnIDs(:), ConnLocs(:), ProxIDs(:), ProxLocs(:)
     INTEGER, ALLOCATABLE :: SConnIDs(:), SProxIDs(:)
     INTEGER :: CCount, PCount, SCCount, SPCount, NID
  END TYPE InvPartInfo_t

  TYPE EF_t
     REAL(KIND=dp) :: M(NOCON),L(NOCON),R(NOCON),F(NOCON),B(NOCON),FR(NOCON),&
          FL(NOCON),BR(NOCON),BL(NOCON)
  END TYPE EF_t

  TYPE NEI_t
     INTEGER :: L=-1,R=-1,F=-1,B=-1,FR=-1,FL=-1,BR=-1,BL=-1
  END TYPE NEI_t

  TYPE UT_t
     REAL(KIND=dp), ALLOCATABLE :: A(:)
     REAL(KIND=dp), POINTER :: M(:)=>NULL(), C(:)=>NULL(), P(:)=>NULL()
  END TYPE UT_t

  TYPE FXF_t
     INTEGER :: M(2,NODC),L(2,NODC),R(2,NODC),F(2,NODC),B(2,NODC),&
          FR(2,NODC),FL(2,NODC),BR(2,NODC),BL(2,NODC)
  END TYPE FXF_t

  TYPE PointEx_t
     INTEGER :: partid=-1,scount=0,rcount=0
     INTEGER, ALLOCATABLE :: SendIDs(:), RecvIDs(:)
     REAL(KIND=dp), ALLOCATABLE :: S(:),R(:)
  END TYPE PointEx_t
END MODULE TypeDefs
