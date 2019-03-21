function [ n,z ] = phoenix(z,const,iter,baseoption,modif,poly)
    MAX_ITER = iter;
    if baseoption == 1
        [n,z] = Mandelbrot(z,iter,modif,poly);
    elseif baseoption == 2
        [n,z] = Julia(z,const,iter,modif,poly);
    elseif baseoption ==3
        [n,z] = Special(z,const,iter,modif);
    end     
end


function [ n,z ] = Mandelbrot(const,iter,modif,poly)
    n = 0;
    prevz = 0;
    newz = 0;
    z = 0;
    while (abs(z) <= 2.0 && n < iter)
        if modif == 1
          % None
          newz = z*z + const;
        elseif modif == 2
          % Phoenix 1
          %default const = 0.56666, - 0.5
          newz = z*z + real(const) + imag(const) * prevz;
        elseif modif == 3
          % Phoenix 2
          %default const = 0.56666,0
          newz = z*z + const - 0.5 * prevz;
        elseif modif == 4
          % Manowar
          %default const = -0.01,0
          newz = z*z + const + prevz;
        elseif modif == 5
          % Burning Ship
          %default const = -0.01,0
          xn1 = real(z)^2 - imag(z)^2 - real(const);
          yn1 = 2 * abs(real(z) * imag(z)) - imag(const);
          newz = complex(xn1,yn1);
        elseif modif == 6 
          % polynomial
          newz = z ^ poly + const;
        end
        prevz = z;
        z = newz;
        n = n + 1;
    end
end


function [ n,z ] = Julia(z,const,iter,modif,poly)
    n = 0;
    prevz = 0;
    newz = 0;
    while (abs(z) <= 2.0 && n < iter)
        if modif == 1
          % None
          %default const = 0.56666, - 0.5
          newz = z*z + const;
        elseif modif == 2
          % Phoenix 1
          %default const = 0.56666, - 0.5
          newz = z*z + real(const) + imag(const) * prevz;
        elseif modif == 3
          % Phoenix 2
          % default const = 0.56666,0
          newz = z*z + const - 0.5 * prevz;
        elseif modif == 4
          % Manowar
          % default const = -0.01,0
          newz = z*z + const + prevz;
        elseif modif == 5
          % Burning Ship
          %default const = -0.01,0
          newz = z*z + const + abs(prevz);
        elseif modif == 6 
          % polynomial
          newz = z ^ poly + const;
        end
        prevz = z;
        z = newz;
        n = n + 1;
    end
end


function [ n,z ] = Special(z,const,iter,modif)
    n = 0;
    prevz = 0;
    newz = 0;
    if modif == 14
       const = z;
       z = 0;
    end
    while (abs(z) <= 2.0 && n < iter)
        if modif == 1 % popcorn
          xn1 = real(z) - 0.05*sin(imag(z) + tan(3*imag(z)));
          yn1 = imag(z) - 0.05*sin(real(z) + tan(3*real(z)));
          newz = complex(xn1,yn1);
        elseif modif == 2 % lambda
           newz = const * z * (1-z);
        elseif modif == 3 % nova-julia
            newz = z - (z^3 - 1)/(3*z^2) + const;
        elseif modif == 4 % newton1
            newz = z - (z^3 - 2*z + 2)/(3*z^2 - 2);
        elseif modif == 5 % newton2
            newz = z - complex(1,1) * (z^2 - 1)/(2*z);
        elseif modif == 6 % newton3
            newz = z - 2 * (z^3-1)/(3*z^2);
        elseif modif == 7 % sin
            newz = sin(z) - const;
        elseif modif == 8 % cosine
            newz = cos(z) - const;
        elseif modif == 9 % exponential
            newz = exp(z) - const;
        elseif modif == 10 % magnetic
            newz = ((z*z + const - 1)/(2*z + const - 2))*2;
        elseif modif == 11 % cosh
            % 0.4, 0.65, iter 30
            newz = z*z - (cosh(z) - 1)/(sinh(z)) + const;
        elseif modif == 12 % sinh
            newz = z*z - (sinh(z) - 1)/(cosh(z)) + const;
        elseif modif == 13 % feather
            newz = z - const*(z^4 - 1)/(4*z^3 + 0.000001);
        elseif modif == 14 % peacock
            newz = z - (z*z - 1)/(const*(z*z +1));
        end
        prevz = z;
        z = newz;
        n = n + 1;
    end
end