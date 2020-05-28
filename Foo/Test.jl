function myabs2(z)
    return real(z)*real(z) + imag(z)*imag(z)
end

function mandel(z)
    c=z
    maxiter = 88
    for n = 1:maxiter
          if myabs2(z) > 4
          return n-1
       end
     z=z^2 + c
  end
  return maxiter
end

mandelperf() = [ mandel(complex(r,i)) for i=-1.:.1:1., r=-2.0:.1:0.5 ]
@test sum(mandelperf()) == 14791
@timeit mandelperf() "userfunc_mandelbrot" "Calculation of mandelbrot set"
