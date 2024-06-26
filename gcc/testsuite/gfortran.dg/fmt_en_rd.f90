! { dg-do run }
! PR60128 Invalid outputs with EN descriptors
! Test case provided by Walt Brainerd.
program pr60128
use ISO_FORTRAN_ENV
    implicit none
    integer, parameter :: j(size(real_kinds)+4)=[REAL_KINDS, [4, 4, 4, 4]]
    logical :: l_skip(4) = .false.
    integer :: i
    integer :: n_tst = 0, n_cnt = 0, n_skip = 0
    character(len=20,kind=4) :: s, s1

!   Check that the default rounding mode is to nearest and to even on tie.
    do i=1,size(real_kinds)
      if (i == 1) then
        write(s, '(2F4.1,2F4.0)') real(-9.49999905,kind=j(1)), &
                                  real(9.49999905,kind=j(1)),  &
                                  real(9.5,kind=j(1)), real(8.5,kind=j(1))
        write(s1, '(3PE10.3,2PE10.3)') real(987350.,kind=j(1)), &
                                       real(98765.0,kind=j(1))
      else if (i == 2) then
        write(s, '(2F4.1,2F4.0)') real(-9.49999905,kind=j(2)), &
                                  real(9.49999905,kind=j(2)),  &
                                  real(9.5,kind=j(2)), real(8.5,kind=j(2))
        write(s1, '(3PE10.3,2PE10.3)') real(987350.,kind=j(2)), &
                                       real(98765.0,kind=j(2))
      else if (i == 3) then
        write(s, '(2F4.1,2F4.0)') real(-9.49999905,kind=j(3)), &
                                  real(9.49999905,kind=j(3)),  &
                                  real(9.5,kind=j(3)), real(8.5,kind=j(3))
        write(s1, '(3PE10.3,2PE10.3)') real(987350.,kind=j(3)), &
                                       real(98765.0,kind=j(3))
      else if (i == 4) then
        write(s, '(2F4.1,2F4.0)') real(-9.49999905,kind=j(4)), &
                                  real(9.49999905,kind=j(4)),  &
                                  real(9.5,kind=j(4)), real(8.5,kind=j(4))
        write(s1, '(3PE10.3,2PE10.3)') real(987350.,kind=j(4)), &
                                       real(98765.0,kind=j(4))
      end if
      if (s /= 4_'-9.5 9.5 10.  8.' .or. s1 /= 4_' 987.4E+03 98.76E+03') then
        l_skip(i) = .true.
        print "('Unsupported rounding for real(',i0,')')", j(i)
      end if
    end do
        

! Original test.
    call checkfmt("(en15.2)", -.44444,    4_"    -444.44E-03")

! Test for the bug in comment 6.
    call checkfmt("(rd,en15.0)", 1.0,        4_"         1.E+00")
    call checkfmt("(rd,en15.0)", 1.00000012, 4_"         1.E+00")
    call checkfmt("(rd,en15.0)", 0.99999994, 4_"       999.E-03")
    call checkfmt("(rd,en15.0)", 10.0,       4_"        10.E+00")
    call checkfmt("(rd,en15.0)", 10.0000010, 4_"        10.E+00")
    call checkfmt("(rd,en15.0)", 9.99999905, 4_"         9.E+00")
    call checkfmt("(ru,en15.0)", 100.0,      4_"       100.E+00")
    call checkfmt("(rd,en15.0)", 100.000008, 4_"       100.E+00")
    call checkfmt("(rd,en15.0)", 99.9999924, 4_"        99.E+00")
    call checkfmt("(rd,en15.0)", 1000.0,     4_"         1.E+03")
    call checkfmt("(rd,en15.0)", 1000.00006, 4_"         1.E+03")
    call checkfmt("(rd,en15.0)", 999.999939, 4_"       999.E+00")
    call checkfmt("(rd,en15.0)", 9.5,        4_"         9.E+00")
    call checkfmt("(rd,en15.0)", 9.50000095, 4_"         9.E+00")
    call checkfmt("(rd,en15.0)", 9.49999905, 4_"         9.E+00")
    call checkfmt("(rd,en15.0)", 99.5,       4_"        99.E+00")
    call checkfmt("(rd,en15.0)", 99.5000076, 4_"        99.E+00")
    call checkfmt("(rd,en15.0)", 99.4999924, 4_"        99.E+00")
    call checkfmt("(rd,en15.0)", 999.5,      4_"       999.E+00")
    call checkfmt("(rd,en15.0)", 999.500061, 4_"       999.E+00")
    call checkfmt("(rd,en15.0)", 999.499939, 4_"       999.E+00")
    call checkfmt("(rd,en15.0)", 9500.0,     4_"         9.E+03")
    call checkfmt("(rd,en15.0)", 9500.00098, 4_"         9.E+03")
    call checkfmt("(rd,en15.0)", 9499.99902, 4_"         9.E+03")
    call checkfmt("(rd,en15.1)", 9950.0,     4_"        9.9E+03")
    call checkfmt("(rd,en15.2)", 9995.0,     4_"       9.99E+03")
    call checkfmt("(rd,en15.3)", 9999.5,     4_"      9.999E+03")
    call checkfmt("(rd,en15.1)", 9.5,        4_"        9.5E+00")
    call checkfmt("(rd,en15.1)", 9.50000095, 4_"        9.5E+00")
    call checkfmt("(rd,en15.1)", 9.49999905, 4_"        9.4E+00")
    call checkfmt("(rd,en15.1)", 0.099951,   4_"       99.9E-03")
    call checkfmt("(rd,en15.1)", 0.009951,   4_"        9.9E-03")
    call checkfmt("(rd,en15.1)", 0.000999951,4_"      999.9E-06")

    call checkfmt("(rd,en15.0)", -1.0,        4_"        -1.E+00")
    call checkfmt("(rd,en15.0)", -1.00000012, 4_"        -2.E+00")
    call checkfmt("(rd,en15.0)", -0.99999994, 4_"        -1.E+00")
    call checkfmt("(rd,en15.0)", -10.0,       4_"       -10.E+00")
    call checkfmt("(rd,en15.0)", -10.0000010, 4_"       -11.E+00")
    call checkfmt("(rd,en15.0)", -9.99999905, 4_"       -10.E+00")
    call checkfmt("(rd,en15.0)", -100.0,      4_"      -100.E+00")
    call checkfmt("(rd,en15.0)", -100.000008, 4_"      -101.E+00")
    call checkfmt("(rd,en15.0)", -99.9999924, 4_"      -100.E+00")
    call checkfmt("(rd,en15.0)", -1000.0,     4_"        -1.E+03")
    call checkfmt("(rd,en15.0)", -1000.00006, 4_"        -2.E+03")
    call checkfmt("(rd,en15.0)", -999.999939, 4_"        -1.E+03")
    call checkfmt("(rd,en15.0)", -9.5,        4_"       -10.E+00")
    call checkfmt("(rd,en15.0)", -9.50000095, 4_"       -10.E+00")
    call checkfmt("(rd,en15.0)", -9.49999905, 4_"       -10.E+00")
    call checkfmt("(rd,en15.0)", -99.5,       4_"      -100.E+00")
    call checkfmt("(rd,en15.0)", -99.5000076, 4_"      -100.E+00")
    call checkfmt("(rd,en15.0)", -99.4999924, 4_"      -100.E+00")
    call checkfmt("(rd,en15.0)", -999.5,      4_"        -1.E+03")
    call checkfmt("(rd,en15.0)", -999.500061, 4_"        -1.E+03")
    call checkfmt("(rd,en15.0)", -999.499939, 4_"        -1.E+03")
    call checkfmt("(rd,en15.0)", -9500.0,     4_"       -10.E+03")
    call checkfmt("(rd,en15.0)", -9500.00098, 4_"       -10.E+03")
    call checkfmt("(rd,en15.0)", -9499.99902, 4_"       -10.E+03")
    call checkfmt("(rd,en15.1)", -9950.0,     4_"      -10.0E+03")
    call checkfmt("(rd,en15.2)", -9995.0,     4_"     -10.00E+03")
    call checkfmt("(rd,en15.3)", -9999.5,     4_"    -10.000E+03")
    call checkfmt("(rd,en15.1)", -9.5,        4_"       -9.5E+00")
    call checkfmt("(rd,en15.1)", -9.50000095, 4_"       -9.6E+00")
    call checkfmt("(rd,en15.1)", -9.49999905, 4_"       -9.5E+00")
    call checkfmt("(rd,en15.1)", -0.099951,   4_"     -100.0E-03")
    call checkfmt("(rd,en15.1)", -0.009951,   4_"      -10.0E-03")
    call checkfmt("(rd,en15.1)", -0.000999951,4_"       -1.0E-03")

    call checkfmt("(rd,en15.1)", 987350.,     4_"      987.3E+03")
    call checkfmt("(rd,en15.2)", 98735.,      4_"      98.73E+03")
    call checkfmt("(rd,en15.3)", 9873.5,      4_"      9.873E+03")
    call checkfmt("(rd,en15.1)", 987650.,     4_"      987.6E+03")
    call checkfmt("(rd,en15.2)", 98765.,      4_"      98.76E+03")
    call checkfmt("(rd,en15.3)", 9876.5,      4_"      9.876E+03")
    call checkfmt("(rd,en15.1)", 3.125E-02,   4_"       31.2E-03")
    call checkfmt("(rd,en15.1)", 9.375E-02,   4_"       93.7E-03")
    call checkfmt("(rd,en15.2)", 1.5625E-02,  4_"      15.62E-03")
    call checkfmt("(rd,en15.2)", 4.6875E-02,  4_"      46.87E-03")
    call checkfmt("(rd,en15.3)", 7.8125E-03,  4_"      7.812E-03")
    call checkfmt("(rd,en15.3)", 2.34375E-02, 4_"     23.437E-03")
    call checkfmt("(rd,en15.3)", 9.765625E-04,4_"    976.562E-06")
    call checkfmt("(rd,en15.6)", 2.9296875E-03,4_"   2.929687E-03")

    call checkfmt("(rd,en15.1)", -987350.,     4_"     -987.4E+03")
    call checkfmt("(rd,en15.2)", -98735.,      4_"     -98.74E+03")
    call checkfmt("(rd,en15.3)", -9873.5,      4_"     -9.874E+03")
    call checkfmt("(rd,en15.1)", -987650.,     4_"     -987.7E+03")
    call checkfmt("(rd,en15.2)", -98765.,      4_"     -98.77E+03")
    call checkfmt("(rd,en15.3)", -9876.5,      4_"     -9.877E+03")
    call checkfmt("(rd,en15.1)", -3.125E-02,   4_"      -31.3E-03")
    call checkfmt("(rd,en15.1)", -9.375E-02,   4_"      -93.8E-03")
    call checkfmt("(rd,en15.2)", -1.5625E-02,  4_"     -15.63E-03")
    call checkfmt("(rd,en15.2)", -4.6875E-02,  4_"     -46.88E-03")
    call checkfmt("(rd,en15.3)", -7.8125E-03,  4_"     -7.813E-03")
    call checkfmt("(rd,en15.3)", -2.34375E-02, 4_"    -23.438E-03")
    call checkfmt("(rd,en15.3)", -9.765625E-04,4_"   -976.563E-06")
    call checkfmt("(rd,en15.6)", -2.9296875E-03,4_"  -2.929688E-03")

    print *, n_tst, n_cnt, n_skip
    if (n_cnt /= 0) stop n_cnt
    if (all(.not. l_skip)) print *, "All kinds rounded down"

contains
    subroutine checkfmt(fmt, x, cmp)
        implicit none
        integer :: i
        character(len=*), intent(in) :: fmt
        real, intent(in) :: x
        character(len=*, kind=4), intent(in) :: cmp
        do i=1,size(real_kinds)
          if (l_skip(i)) cycle
          if (i == 1) then
            write(s, fmt) real(x,kind=j(1))
          else if (i == 2) then
            write(s, fmt) real(x,kind=j(2))
          else if (i == 3) then
            write(s, fmt) real(x,kind=j(3))
          else if (i == 4) then
            write(s, fmt) real(x,kind=j(4))
          end if
          n_tst = n_tst + 1
          if (s /= cmp) then
            if (l_skip(i)) then
              n_skip = n_skip + 1
            else
              print "(a,1x,a,' expected: ',1x,a)", fmt, s, cmp
              n_cnt = n_cnt + 1
            end if
          end if
        end do
        
    end subroutine
end program
! { dg-output "All kinds rounded down" { xfail hppa*-*-hpux* } }
! { dg-final { cleanup-saved-temps } }
