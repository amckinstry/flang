! Copyright (c) 2004, NVIDIA CORPORATION.  All rights reserved.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
!
! test EOSHIFT and CSHIFT, nested
! one dimension
	program p
	 implicit none
	 integer, parameter :: N=5
	 integer, dimension(N) :: src
	 integer, dimension(N) :: eopc,eopv,cpc,cpv
	 integer, dimension(N) :: eomc,eomv,cmc,cmv
	 integer, dimension(N) :: eopcres,eopvres,cpcres,cpvres
	 integer, dimension(N) :: eomcres,eomvres,cmcres,cmvres
	 integer :: i,j,k
        data eopcres/   3,   4,   5,   9,   0/
        data eopvres/   3,   4,   5,   9,   0/
        data eomcres/   0,   2,   3,   4,   5/
        data eomvres/   0,   2,   3,   4,   5/
        data  cpcres/   3,   4,   5,   9,   2/
        data  cpvres/   3,   4,   5,   9,   2/
        data  cmcres/   9,   2,   3,   4,   5/
        data  cmvres/   9,   2,   3,   4,   5/
	logical,parameter :: doprint = .false.
	 eopc = -10	! fill in with garbage
	 eopv = -10
	 eomc = -10
	 eomv = -10
	 cpc = -10
	 cpv = -10
	 cmc = -10
	 cmv = -10
	 call sub(j,k)	! j is positive, k is negative
	 src=(/(i,i=1,N)/)	! initialize
	 eopc=eoshift(eoshift(src,1,9), 1)	! eoshift, positive, constant
	 eopv=eoshift(eoshift(src,1,9), j)	! eoshift, positive, variable
	 eomc=eoshift(eoshift(src,1,9),-1)	! eoshift, negative, constant
	 eomv=eoshift(eoshift(src,1,9), k)	! eoshift, negative, variable
	  cpc= cshift(eoshift(src,1,9), 1)	!  cshift, positive, constant
	  cpv= cshift(eoshift(src,1,9), j)	!  cshift, positive, variable
	  cmc= cshift(eoshift(src,1,9),-1)	!  cshift, negative, constant
	  cmv= cshift(eoshift(src,1,9), k)	!  cshift, negative, variable
	 if( doprint )then
	  print 10, 'eopc',eopc
	  print 10, 'eopv',eopv
	  print 10, 'eomc',eomc
	  print 10, 'eomv',eomv
	  print 10, ' cpc', cpc
	  print 10, ' cpv', cpv
	  print 10, ' cmc', cmc
	  print 10, ' cmv', cmv
10	  format( '        data ',a,'res/',4(i4,','),i4,'/')
	 else
	  call check(eopc,eopcres,N)
	  call check(eopv,eopvres,N)
	  call check(eomc,eomcres,N)
	  call check(eomv,eomvres,N)
	  call check(cpc,cpcres,N)
	  call check(cpv,cpvres,N)
	  call check(cmc,cmcres,N)
	  call check(cmv,cmvres,N)
	 endif
	end
	subroutine sub(j,k)
	 j = 1
	 k = -1
	end
